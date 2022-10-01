class Object
  def to_proc
    method = case
             when respond_to?(:call)
               :call
             when respond_to?(:[])
               :[]
             else
               :===
             end
    proc { send(method, _1) }
  end
end
