# import libraries
import time
import numpy as np
import sys
import pandas as pd
import os

# import pokemon data from external sources (csv)
pokemons = pd.read_csv(r"C:\Users\monkeyluffy14\Ironhack\Project1_Pokemon\inputs\Kanto Pokemon Spreadsheet.csv")
moves = pd.read_csv(r"C:\Users\monkeyluffy14\Ironhack\Project1_Pokemon\inputs\Pokemon Moves.csv")
type_advantage = pd.read_csv(r"C:\Users\monkeyluffy14\Ironhack\Project1_Pokemon\inputs\Type Advantages.csv")

# clean up data
# keeping columns we need and removing unnecessary columns
pokemons = pokemons[['Pokemon', 'Type I', 'Type II', 'HP',  'Spe', 'Move 1 ', 'Move 2', 'Move 3', 'Move 4']] 
moves = moves[[ 'Name   ', 'Effect', 'Type   ', 'Power']]
moves.columns = moves.columns.str.replace(' ', '')
moves = moves.drop(index = 0)

pokemons['Type'] = pokemons[['Type I', 'Type II']].values.tolist()
pokemons['Moves'] = pokemons[['Move 1 ', 'Move 2','Move 3','Move 4']].values.tolist()
# building a smaller dataframe with only columns that will be requested later
Pokemon = pokemons[['Pokemon','Spe', 'HP', 'Type', 'Moves']]
Pokemon=Pokemon.rename(columns = {'Pokemon':'Name', 'Spe':'Speed', 'HP':'Health','Moves':'Move'})

# for each game, pick 20 random pokemons from the pool
Pokemon = Pokemon.sample(n=20).reset_index()
# print(Pokemon)

# print one character at a time
def delay_print(s):
    # https://stackoverflow.com/questions/9246076/how-to-print-one-character-at-a-time-on-one-line
    for c in s:
        sys.stdout.write(c)
        sys.stdout.flush()
        time.sleep(0.05)
        
# starting the ans flag as "yes", after the first game, if the user decides to continue with "yes", the code will run again     
ans = 'yes'
while ans == 'yes':

    delay_print('Welcome to the Pokemon World !\nPlease choose one of the 20 pokemons below (enter a number between 1-20):\n')
    # printing a pair of (index+1 and Pokemon name)
    for i, j in enumerate(Pokemon['Name']):
        print(f"{i+1}. ",j)

    # make sure the number entered is valid
    # if accidentally pressed enter, ask for input until valid
    pokemon1 = int(input("Please choose the first Pokemon: ")) -1
    if pokemon1 not in range(0,20):
        pokemon1 = int(input("Please put a valid number:")) -1

    pokemon2 = int(input("Please choose the second Pokemon: ")) -1
    if pokemon2 not in range(0,20):
        pokemon2 = int(input("Please put a valid number:")) -1

    # print battle start message & players info
    delay_print("\n\n===========BATTLE STARTS !=========\n\n\n")

    delay_print(f"Name: {Pokemon.loc[pokemon1,'Name']}\n")
    delay_print(f"Type: {Pokemon.loc[pokemon1,'Type']}\n")
    delay_print(f"HP: {Pokemon.loc[pokemon1,'Health']}\n")
    delay_print(f"Speed: {Pokemon.loc[pokemon1,'Speed']}\n\n")


    delay_print('VS\n\n')
    delay_print(f"Name: {Pokemon.loc[pokemon2,'Name']}\n")
    delay_print(f"Type: {Pokemon.loc[pokemon2,'Type']}\n")
    delay_print(f"Health: {Pokemon.loc[pokemon2,'Health']}\n")
    delay_print(f"Speed: {Pokemon.loc[pokemon2,'Speed']}\n\n")

    # decide who attacks first based on speed
    speed_1 = Pokemon.loc[pokemon1,'Speed']
    speed_2 = Pokemon.loc[pokemon2,'Speed']

    # compare the speed and set up 1st & 2nd attackers accordingly
    if speed_1 > speed_2:
        delay_print(f"{Pokemon.loc[pokemon1,'Name']} is attacking first!\n\n")
        first_attacker = Pokemon.loc[pokemon1]
        second_attacker = Pokemon.loc[pokemon2]

    else:
        delay_print(f"{Pokemon.loc[pokemon2,'Name']} is attacking first!\n\n")
        first_attacker = Pokemon.loc[pokemon2]
        second_attacker = Pokemon.loc[pokemon1]

    # store the moves in a separate variable
    first_attacker_moves = first_attacker['Move']
    second_attacker_moves = second_attacker['Move']

    # print out moves info
    for x,i in enumerate(first_attacker_moves):
        power = moves[moves['Name']==i]['Power'].to_string(index = False)
        types = moves[moves['Name']==i]['Type'].to_string(index = False)

        print(f"{x+1}. {i}  |  Power: {power} |  Type: {types}")

    # before starting the while loop, store the HP of both players in variables outside of loop
    health_2nd_attacker = second_attacker['Health'] 
    health_1st_attacker = first_attacker['Health']

    # start the loop, only break if one of the players has 0 or negative HP
    while True:

        move_picked = int(input('please choose a move:'))-1
        if move_picked not in range(0,4):
            move_picked = int(input("Please put a valid number:")) -1

        move_name = first_attacker_moves[move_picked]
        delay_print(f"{first_attacker['Name']} is using {move_name}!\n")
        time.sleep(0.5)

        original_damage = float(moves[moves['Name']==move_name]['Power'].to_string(index = False))

        # we use type of the attack as attack type, type of the character as defense type

        type_1st_attacker = moves[moves['Name']==move_name]['Type'].to_string(index = False)

        # for simplicity reason pick the first type for monsters with multiple types
        type_2nd_attacker = second_attacker['Type'][0]
        mult = type_advantage.loc[(type_advantage['Attack Type']==type_1st_attacker)&(type_advantage['Defense Type']==type_2nd_attacker),'Multiplier']
        if len(mult) == 0:
    #         print('multi not found')
            mult = 1.0
        else:
    #         print('multiplier found')
            mult = float(mult.to_string(index=False))

        # calculate the final damage with type advantage
        base_damage = mult * original_damage
        # print out damage msg
        delay_print(f"{first_attacker['Name']} has dealt {original_damage} x {mult} = {base_damage} damage\n")
        if mult > 1:
            print("\nIts super effective!!!")
        elif mult == 1:
            print("\nIts a normal attack.")
        else:
            print('\nIts not very effective...')
        time.sleep(0.5)

        # deduct damage from HP of the opponent and print
        health_2nd_attacker  -=  base_damage
        if health_2nd_attacker <0:
            health_2nd_attacker = 0
        delay_print(f"{second_attacker['Name']} has {health_2nd_attacker} HP left\n")

        # check and exit loop if the player's HP <= 0
        if health_2nd_attacker <=0:
            delay_print(f"{second_attacker['Name']} fainted!\n")
            time.sleep(0.5)
            delay_print(f"\n...")
            time.sleep(0.5)
            delay_print(f"\n...\n\n")
            time.sleep(0.5)
            # send congratulation message to the winner
            delay_print(f"{first_attacker['Name']} won ! Congratulations !!!")
            break

        # otherwise keep fighting, switch to opponent's turn
        else:
            time.sleep(1)
            delay_print(f"\n\nNow {second_attacker['Name']} attacking!\n\n")

        # print out moves info
        for x,i in enumerate(second_attacker_moves):
            power = moves[moves['Name']==i]['Power'].to_string(index = False)
            types = moves[moves['Name']==i]['Type'].to_string(index = False)
            print(f"{x+1}. {i}  |  Power: {power} |  Type: {types}")    

        move_picked = int(input('please choose a move:'))-1
        if move_picked not in range(0,4):
            move_picked = int(input("Please put a valid number:")) -1

        move_name = second_attacker_moves[move_picked]
        delay_print(f"{second_attacker['Name']} is using {move_name}!\n")
        time.sleep(0.5)

        original_damage = float(moves[moves['Name']==move_name]['Power'].to_string(index = False))

        # we use type of the attack as attack type, type of the character as defense type

        type_2nd_attacker = moves[moves['Name']==move_name]['Type'].to_string(index = False)

        # for simplicity reason pick the first type for monsters with multiple types
        type_1st_attacker = first_attacker['Type'][0]
        mult = type_advantage.loc[(type_advantage['Attack Type']==type_2nd_attacker)&(type_advantage['Defense Type']==type_1st_attacker),'Multiplier']
        if len(mult) == 0:
    #         print('multi not found')
            mult = 1.0
        else:
    #         print('multiplier found')
            mult = float(mult.to_string(index=False))

        # calculate the final damage with type advantage
        base_damage = mult * original_damage
        # print out damage msg
        delay_print(f"{second_attacker['Name']} has dealt {original_damage} x {mult} = {base_damage} damage\n")
        if mult > 1:
            print("\nIts super effective!!!")
        elif mult == 1:
            print("\nIts a normal attack.")
        else:
            print('\nIts not very effective...')
        time.sleep(0.5)

        # deduct damage from HP of the opponent and print
        health_1st_attacker  -=  base_damage
        if health_1st_attacker <0:
            health_1st_attacker = 0
        delay_print(f"{first_attacker['Name']} has {health_1st_attacker} HP left\n")

        # check and exit loop if the player's HP <= 0
        if health_1st_attacker <=0:
            delay_print(f"{first_attacker['Name']} fainted!\n")
            time.sleep(0.5)
            delay_print(f"\n...")
            time.sleep(0.5)
            delay_print(f"\n...\n\n")
            time.sleep(0.5)
            # send congratulation message to the winner
            delay_print(f"{second_attacker['Name']} won ! Congratulations !!!")
            break

        # otherwise keep fighting, switch to opponent's turn
        else:
            time.sleep(1)
            delay_print(f"\n\nNow {first_attacker['Name']} attacking!\n\n")
            
    delay_print('The game has finished Ϟ(๑• .̫ •๑)∩\n')
    ans = input("Another round ? (yes/no)").lower()
else:
    delay_print("see you next time !")
        
