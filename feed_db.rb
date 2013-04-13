
input = open("test_data_04042013.json", &:read)
arr = input.scan(/(\{.[^{}]*\})/)
arr.each do |x|
  z = x[0].tr('{}"', '')
  h = Hash.new
  z.split(',').each do |ret|  
    f = ret.split(':')
    h[f[0]] = f[1]
  end
  @id = h["CHRNumber"] + ':' + h["CKRNumber"] + ':' + h["CKRAdditionalNumber"]
  @descr = h["BirthDate"].tr('/\\', '') + ':' + h["RaceCode"] + ':' + h["CategoryCode"] + ':' + h["Ecological"]
#  system("curl -d \"localid=#{@id}&owner=3&description=#{@descr}\" http://entity-manager.herokuapp.com/entities.xml")
  system("curl -d \"localid=#{@id}&owner=3&description=#{@descr}\" http://localhost:3000/entities.xml")
end
puts arr.length

