defmodule HangmanCli.Mover do
  alias HangmanCli.State

  def make_move(state = %State{}) do
    {gs, tally} = Hangman.make_move(state.game_service, state.guess)
    %State{state | game_service: gs, tally: tally}
  end
end
