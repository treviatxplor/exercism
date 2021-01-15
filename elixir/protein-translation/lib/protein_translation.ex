defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    split_rna_into_codons(rna)
    |> Enum.reduce_while({:ok, []}, fn(codon, acc) ->
         case of_codon(codon) do
          {:ok, "STOP"} -> {:halt, acc}
          {:error, _} -> {:halt, {:error, "invalid RNA"}}
          {:ok, protein} -> {:cont, {:ok, elem(acc, 1) ++ [protein]}}
         end
    end)
  end

  defp split_rna_into_codons(rna) do
    String.codepoints(rna)
    |> Enum.chunk_every(3)
    |> Enum.reduce([], fn(nucleotide, codons) ->
      codons ++ [Enum.join(nucleotide)]
    end)
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon("UGU"), do: {:ok, "Cysteine"}

  def of_codon("UGC"), do: {:ok, "Cysteine"}

  def of_codon("UUA"), do: {:ok, "Leucine"}

  def of_codon("UUG"), do: {:ok, "Leucine"}

  def of_codon("AUG"), do: {:ok, "Methionine"}

  def of_codon("UUU"), do: {:ok, "Phenylalanine"}

  def of_codon("UUC"), do: {:ok, "Phenylalanine"}

  def of_codon("UCU"), do: {:ok, "Serine"}

  def of_codon("UCC"), do: {:ok, "Serine"}

  def of_codon("UCA"), do: {:ok, "Serine"}

  def of_codon("UCG"), do: {:ok, "Serine"}

  def of_codon("UGG"), do: {:ok, "Tryptophan"}

  def of_codon("UAU"), do: {:ok, "Tyrosine"}

  def of_codon("UAC"), do: {:ok, "Tyrosine"}

  def of_codon("UAA"), do: {:ok, "STOP"}

  def of_codon("UAG"), do: {:ok, "STOP"}

  def of_codon("UGA"), do: {:ok, "STOP"}

  def of_codon(_), do: {:error, "invalid codon"}
end
