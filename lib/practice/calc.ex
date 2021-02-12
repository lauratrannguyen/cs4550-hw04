defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  # Takes in an expression
  def calc(expr) do
    arr = String.split(expr)
    tagged = tagItems(arr)
    postfix = createPostList(tagged, [], [])
    answer = createPrefix(postfix, [])
    answer
  end

  # Tags the items in a tuple
  def tagItems(arr) do
    Enum.map(arr, fn token -> 
    case token do
      "*" -> {:op, "*"}
      "/" -> {:op, "/"}
      "+" -> {:op, "+"}
      "-" -> {:op, "-"}
      _ -> {:num, parse_float(token)}
    end end)
  end

  # Creates the postfix form
  def createPostList(arr, currList, stack) do
    cond do
      (arr == []) ->
        currList ++ stack
      (elem(hd(arr), 1) == "+" || elem(hd(arr), 1) == "-") ->
        char = elem(hd(arr), 1)
        cond do
          (stack == []) ->
            stack = [char] ++ stack
            createPostList(tl(arr), currList, stack) 
          (hd(stack) == "*" || hd(stack) == "/") ->
            currList = currList ++ [hd(stack)]
            stack = stack -- [hd(stack)]
            stack = [char] ++ stack
            createPostList(tl(arr), currList, stack) 
          true ->
            stack = [char] ++ stack
            createPostList(tl(arr), currList, stack) 
        end
      (elem(hd(arr), 1) == "*" || elem(hd(arr), 1) == "/") ->
        char = elem(hd(arr), 1)
        cond do 
          (stack == []) ->
            stack = [char] ++ stack
            createPostList(tl(arr), currList, stack) 
          (hd(stack) == "+" || hd(stack) == "-") ->
            stack = [char] ++ stack
            createPostList(tl(arr), currList, stack) 
          (hd(stack) == "*" || hd(stack) == "/") ->
            currList = currList ++ [hd(stack)]
            stack = stack -- [hd(stack)]
            stack = [char] ++ stack
            createPostList(tl(arr), currList, stack) 
        end
      true ->
        char = elem(hd(arr), 1)
        currList = currList ++ [char]
        createPostList(tl(arr), currList, stack) 
      end
  end

  # Solves the postfix form
  def createPrefix(arr, stack) do
    cond do
      (arr == []) ->
        hd(stack)
      (hd(arr) == "*") ->
        eval = hd(stack) * hd(tl(stack))
        stack = stack -- [hd(stack)]
        stack = stack -- [hd(stack)]
        stack = [eval] ++ stack 
        createPrefix(tl(arr), stack)
      (hd(arr) == "/") ->
        eval = hd(tl(stack)) / hd(stack) 
        stack = stack -- [hd(stack)]
        stack = stack -- [hd(stack)]
        stack = [eval] ++ stack 
        createPrefix(tl(arr), stack)
      (hd(arr) == "+") ->
        eval = hd(stack) + hd(tl(stack))
        stack = stack -- [hd(stack)]
        stack = stack -- [hd(stack)]
        stack = [eval] ++ stack 
        createPrefix(tl(arr), stack)
      (hd(arr) == "-") ->
        eval = hd(tl(stack)) - hd(stack)
        stack = stack -- [hd(stack)]
        stack = stack -- [hd(stack)]
        stack = [eval] ++ stack 
        createPrefix(tl(arr), stack)
      true -> 
        char = hd(arr)
        stack = [char] ++ stack
        createPrefix(tl(arr), stack)
     end   
  end

end
