def count_legacyids(records)
  legacy_ids = {}
  records.each do |r|
    legacy_ids[r['legacyId']] = 0 if legacy_ids[r['legacyId']].nil?
    legacy_ids[r['legacyId']] += 1
  end

  legacy_ids
end

def find_duplicate_legacy_ids(records, legacy_ids)
  duplicate_keys = legacy_ids.select { |_, v| v > 1 }.keys
  records.select { |r| duplicate_keys.include?(r['legacyId']) }
end

def find_orphaned(records, legacy_ids)
  records.select { |r| !legacy_ids.keys.include?(r['parentId']) }
end

def find_nil_records(records)
  records.select { |r| r['legacyId'].nil? }
end

def find_self_referencing(records)
  records.select { |r| !r['parentId'].nil? && (r['legacyId'] == r['parentId']) }
end

def sort_csv(records, parents = nil)
  # if parents is nil, this is the first iteration
  parents = records.select { |r| r['parentId'].nil? } if parents.nil?

  # figure out if records have parents in parents
  ids = parents.map { |r| r['legacyId'] }
  children = records.select { |r| ids.include?(r['parentId']) }
  return parents if children.count == 0

  records -= children
  parents + sort_csv(records, children)
end
