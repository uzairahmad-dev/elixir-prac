defmodule Cards do
  @moduledoc """
    Provide Methods For Creating & Handling a Deck of Card
  """

  @doc """
    Return a List of Strings representing a deck of playing cards
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    #? Solution No. 1
    #* cards = for value <- values do
    #*    for suit <- suits do
    #*      "#{value} of #{suit}"
    #*    end
    #*  end
    #* List.flatten(cards)

    #* Solution No. 2
    #* Multiple Comprehensions
    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end

  end

  def shuffle deck do
    Enum.shuffle(deck)
  end

  @doc """
    Determines whether a deck contains a given card

  ## Example

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true

  """
  def contains? deck, card do
    Enum.member?(deck,card)
  end

  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates how many cards should be in the hand.

  ## Example

       iex> deck = Cards.create_deck
       iex> {hand, deck} = Cards.deal(deck, 1)
       iex> hand
       ["Ace of Spades"]

  """
  def deal deck, hand_size do
    Enum.split(deck, hand_size)
  end

  def save deck, file_name do
    binary = :erlang.term_to_binary(deck)
    File.write(file_name, binary)
  end

  def load file_name do
    case File.read file_name do
      {:ok, binary} -> :erlang.binary_to_term binary
      {:error, _reason} -> "File doesn't exist"
    end
  end

  def create_hand(hand_size) do
    ##? Without Pipe Operator
    # deck = Cards.create_deck
    # deck = Cards.shuffle(deck)
    # hand = Cards.deal(deck, hand_size)

    ##? With Pipe Operator
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)

  end
end


##* Arity --> No. of args a function can accept // shuffle/1
##* Immutability in elixir ---> Every modification in every data structure returns a new data not a modified or existing one.
##* ? --> Method name ends with '?' probably return boolean value
##* case, pattern matching
##* Atom :ok, :error.... ---> For Handling status code, messages...
##* Pipe Operator |> ---> Chain Functions Call
##* Two Types of data structures
##? Maps (Like objects in Javascript)
##* colors = %{primary: "red", secondary: blue} --> colors.primary || %{secondary: secondary_color} = colors
##* Updating data in Maps --> Map.put(colors, :secondary, "green") ---> %{ colors | primary: "red" }
##? Keyword List (Like List & Tuples Together)
##* colors = [{:primary, "red"}, {:secondary, "green"}] --> [primary: "red", secondary: "green"] --> colors[:primary] --> red
