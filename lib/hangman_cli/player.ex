defmodule HangmanCli.Player do
  alias HangmanCli.{Mover, Prompter, State, Summary}

  # won, lost, good guess, bad guess, already used, initializing
  def play(state = %State{tally: %{game_state: :won}}) do
    word = Enum.join(state.game_service.letters)
    exit_with_message("#{word}! You WIN!")
  end

  def play(state = %State{tally: %{game_state: :lost}}) do
    word = Enum.join(state.game_service.letters)
    exit_with_message("Sorry, you lost (the word was: #{word})")
  end

  def play(state = %State{tally: %{game_state: :good_guess}}) do
    continue_with_message(state, "Good guess!")
  end

  def play(state = %State{tally: %{game_state: :bad_guess}}) do
    continue_with_message(state, "Sorry, that isn't in the word")
  end

  def play(state = %State{tally: %{game_state: :already_used}}) do
    continue_with_message(state, "You've already used that letter")
  end

  def play(state = %State{}) do
    continue(state)
  end

  def continue(state = %State{}) do
    state
    |> Summary.display!()
    |> Prompter.accept_move()
    |> Mover.make_move()
    |> play()
  end

  def continue_with_message(state = %State{}, msg) do
    IO.puts(msg)
    continue(state)
  end

  defp exit_with_message(msg) do
    IO.puts(msg)
    exit(:normal)
  end
end
