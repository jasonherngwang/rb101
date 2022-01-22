def foo(param = "no")
  "yes"
end

def bar(param = "no")
  param == "no" ? "yes" : "no"
end

p bar(foo)
# foo() evaluates to 'yes'.
# bar('yes')
# 'yes' == 'no' ? => false
# return 'no'