class Array
  # Deletes the elements speicified at a particular index
  def delete_indexes(*index_array)
    [index_array].flatten.each do |index|
      self[index] = nil
    end
    self.compact
  end
end