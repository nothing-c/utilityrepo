open System

type Team = Arkansas | OU | Mizzou

let beats t = 
  match t with
    | Arkansas -> [Mizzou; OU]
    | Mizzou -> [OU]
    | OU -> [Arkansas]

let choose (tl: Team list) = 
    let r = new System.Random() in 
    tl[r.Next tl.Length]

let cycle = beats >> choose	// randomly choose a team that beat the given

// generate cycle of length n starting with team t	
let rec ncycle (t: Team) n = 
    match n with
        | 0 -> [t]
        | _ -> let t' = cycle t in t :: (ncycle t' (n-1))

// abandoned
// let index i = (i, 2 * i) // for tortoise & hare
// let findcycle (tl: Team list) = 
//     List.map index [1..(tl.Length-1)] 
//     |> List.fold (fun s (t: int, h: int) -> s || (tl[t] = tl[h % tl.Length])) false //does a cycle exist?
