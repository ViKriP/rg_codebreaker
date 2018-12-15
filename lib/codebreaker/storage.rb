# frozen_string_literal: true

module Codebreaker
  class Storage
    def save(data)
      data_db = load
      data_db.push(data)

      File.open(STATS_DB, 'w') { |file| file.write(YAML.dump(data_db)) }
    end

    def load_stats_table
      db = data_sort

      headings = ['Rating']
      rows = []
      db.first.each_key { |key| headings << key.capitalize }
      db.each_with_index do |record, position|
        row = []
        row << position + 1
        record.each { |pair| row << pair.last }
        rows << row
      end

      table_console('Stats', headings, rows)
    end

    private

    def data_sort
      db = load
      db.sort_by! { |x| [x[:attempts_total], x[:attempts_used], x[:hints_used]] }
    end

    def table_console(title, headings, rows)
      Terminal::Table.new title: title, headings: headings, rows: rows
    end

    def load
      File.exist?(STATS_DB) ? YAML.load_file(STATS_DB) : []
    end
  end
end
