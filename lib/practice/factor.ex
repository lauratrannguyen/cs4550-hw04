defmodule Practice.Factor do

    def factor(x) do
        prime = []
        bothValues = divideTwo(prime, x)
        newPrime = hd(bothValues)
        newX = hd(tl(bothValues))
        finalStack = divideOdd(newPrime, 3, newX)
        finalStack
    end

    def divideTwo(stack, x) do
        cond do
            (rem(x, 2) != 0) ->
                [stack, x]
            true ->
                stack = stack ++ [2]
                divideTwo(stack, div(x, 2))
        end
    end

    def divideOdd(stack, currDiv, x) do
        cond do
            (x == 1) ->
                stack
            (currDiv > :math.sqrt(x)) ->
                stack ++ [x]
            (currDiv == x) ->
                stack ++ [currDiv]
            (rem(x, currDiv) == 0) ->
                stack = stack ++ [currDiv]
                divideOdd(stack, currDiv, div(x, currDiv))
            true ->
                divideOdd(stack, currDiv + 2, x)
        end
    end

end