module ProductsHelper
  def get_docid_by_query(q)
    docid = nil
    if q.start_with? 'http'
      p = q.index('docid=')
      unless p.nil?
        docid = q[p+6,32]
      end
    else
      docid = q
    end
    docid = nil if docid.size!=32

    return docid
  end
end
