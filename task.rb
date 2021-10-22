class Task
    attr_reader :id
    attr_accessor :title, :description, :done

    def initialize(attrs = {})
        @id = attrs[:id]
        @title = attrs[:title]
        @description = attrs[:description]
        @done = attrs[:done] || false
    end

    def done!
        @done = true
    end

    def self.find(id)

      #id = "733; DELETE all"
      row = DB.execute("SELECT * FROM tasks WHERE id = ?", id).first
      define_task(row)
    end

    def save
        check = @done ? 1 : 0
        if @id.nil?
            DB.execute("INSERT INTO tasks (title, description, done) VALUES (?, ?, ?)", @title, @description, check )
            @id = DB.last_insert_row_id
        else
            DB.execute("UPDATE tasks SET title= ?, description= ?, done= ?", @title, @description, check)
        end
    end

    def self.all
      rows = DB.execute("SELECT * FROM tasks")
        rows.map { |row| define_task(row) }
    end

    def delete
        DB.execute("DELETE FROM tasks WHERE id = ?", @id) if !@id.nil?
    end

    private

    def self.define_task(row)
        id = row["id"]
        title = row["title"]
        description = row["description"]
        done = row["done"] == 1
        Task.new(id: id, title: title, description: description, done: done)
    end
end

# 45 16 4 5
