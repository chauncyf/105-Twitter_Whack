def parse_score(index)
  if index == 0
    'Congratulation, you got whacked!'
  elsif index < 5
    'Excellent!'
  elsif index < 10
    'That\'s pretty good'
  elsif index < 50
    'Well done'
  elsif index < 90
    'Ok, what about try again'
  else
    'That\'s not good, try again!'
  end
end
