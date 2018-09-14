defmodule HangmanCli.Player do
  alias HangmanCli.{Mover, Prompter, State, Summary}

  # won, lost, good guess, bad guess, already used, initializing
  def play(%State{tally: %{game_state: :won}}) do
    exit_with_message("You WIN!")
  end

  def play(state = %State{tally: %{game_state: :lost}}) do
    word = Enum.join(state.game_service.letters)
    exit_with_message("Sorry, you lost (the word was: #{word})")
  end

  def play(game = %State{tally: %{game_state: :good_guess}}) do
    continue_with_message(game, "Good guess!")
  end

  def play(game = %State{tally: %{game_state: :bad_guess}}) do
    continue_with_message(game, "Sorry, that isn't in the word")
  end

  def play(game = %State{tally: %{game_state: :already_used}}) do
    continue_with_message(game, "You've already used that letter")
  end

  def play(game) do
    continue(game)
  end

  def continue(game) do
    game
    |> Summary.display!()
    |> Prompter.accept_move()
    |> Mover.make_move()
    |> play()
  end

  def continue_with_message(game, msg) do
    IO.puts(msg)
    continue(game)
  end

  defp exit_with_message(msg) do
    IO.puts(msg)
    exit(:normal)
  end
end
