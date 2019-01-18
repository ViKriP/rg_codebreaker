# frozen_string_literal: true

module Codebreaker
  class Storage
    STATS_DB = './lib/db/stats.yml'

    def save(data)
      data_db = load
      data_db.push(data)

      File.open(STATS_DB, 'w') { |file| file.write(YAML.dump(data_db)) }
    end

    def load_stats_table
      return false unless data_sort

      table_console(data_sort)
    end

    def load
      File.exist?(STATS_DB) ? YAML.load_file(STATS_DB) : []
    end

    private

    def data_sort
      db = load
      return false if db.size.zero?

      db.sort_by! { |x| [x[:attempts_total], x[:attempts_used], x[:hints_used]] }
    end

    def table_console(data_stats)
      headings = ['Rating']
      rows = []
      data_stats.first.each_key { |key| headings << key.capitalize }
      data_stats.each_with_index do |record, position|
        row = []
        row << position + 1
        record.each { |pair| row << pair.last }
        rows << row
      end

      Terminal::Table.new title: 'Stats', headings: headings, rows: rows
    end
  end
end
