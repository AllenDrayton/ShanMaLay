extends Node

# This is Pragmatic Script
var balance

var Slot_Page = 1

var can_press = true

# Web Socket Variables
export var websocket_url = "ws://redboxmm.tech:8081/acrf-qarava-slot/slotplaysocket"
var _client = WebSocketClient.new()
var isExit = false
var isPlaying = false

var filepath="res://pck/assets/slot/slot-game-AWC(KINGMAKER).json"
var acesskey
var game_name

var PRAGMATIC_LIST = {
	
	"Gates of Olympus": ["vs20olympgate", preload("res://pck/assets/slot/pragmatic/155a.png")],
	"Sugar Rush": ["vs20sugarrush", preload("res://pck/assets/slot/pragmatic/180a.png")],
	"Sweet Bonanza": ["vs20fruitsw", preload("res://pck/assets/slot/pragmatic/122a.png")],
	"Starlight Princess": ["vs20starlight", preload("res://pck/assets/slot/pragmatic/176a.png")],
	"5 Lions Megaways": ["vswayslions", preload("res://pck/assets/slot/pragmatic/349a.png")],
	"Starlight Princess 1000": ["vs20starlightx", preload("res://pck/assets/slot/pragmatic/177a.png")],
	"The Dog House Megaways": ["vswaysdogs", preload("res://pck/assets/slot/pragmatic/336a.png")],
	"Sweet Bonanza Xmas": ["vs20sbxmas", preload("res://pck/assets/slot/pragmatic/169a.png")],
	"5 Rabbits Megaways": ["vswaysrabbits", preload("res://pck/assets/slot/pragmatic/358a.png")],
	"Gates of Gatot Kaca": ["vs20gatotgates", preload("res://pck/assets/slot/pragmatic/124a.png")],
	"Baccarat": ["bca", preload("res://pck/assets/slot/pragmatic/1a.png")],
	"Multihand Blackjack": ["bjma", preload("res://pck/assets/slot/pragmatic/2a.png")],
	"American Blackjack": ["bjmb", preload("res://pck/assets/slot/pragmatic/3a.png")],
	"Dragon Bonus Baccarat": ["bnadvanced", preload("res://pck/assets/slot/pragmatic/4a.png")],
	"Dragon Tiger": ["bndt", preload("res://pck/assets/slot/pragmatic/5a.png")],
	"Irish Charms": ["cs3irishcharms", preload("res://pck/assets/slot/pragmatic/6a.png")],
	"Diamonds are Forever 3 Lines": ["cs3w", preload("res://pck/assets/slot/pragmatic/7a.png")],
	"Money Roll": ["cs5moneyroll", preload("res://pck/assets/slot/pragmatic/8a.png")],
	"888 Gold": ["cs5triple8gold", preload("res://pck/assets/slot/pragmatic/9a.png")],
	"Roulette": ["rla", preload("res://pck/assets/slot/pragmatic/10a.png")],
	"Fire Hot 100™": ["vs100firehot", preload("res://pck/assets/slot/pragmatic/11a.png")],
	"Shining Hot 100": ["vs100sh", preload("res://pck/assets/slot/pragmatic/12a.png")],
	"Jade Butterfly": ["vs1024butterfly", preload("res://pck/assets/slot/pragmatic/13a.png")],
	"The Dragon Tiger": ["vs1024dtiger", preload("res://pck/assets/slot/pragmatic/14a.png")],
	"Gorilla Mayhem™": ["vs1024gmayhem", preload("res://pck/assets/slot/pragmatic/15a.png")],
	"5 Lions Dance": ["vs1024lionsd", preload("res://pck/assets/slot/pragmatic/16a.png")],
	"Mahjong Panda": ["vs1024mahjpanda", preload("res://pck/assets/slot/pragmatic/17a.png")],
	"Mahjong Wins": ["vs1024mahjwins", preload("res://pck/assets/slot/pragmatic/18a.png")],
	"Moonshot™": ["vs1024moonsh", preload("res://pck/assets/slot/pragmatic/19a.png")],
	"Temujin Treasures": ["vs1024temuj", preload("res://pck/assets/slot/pragmatic/20a.png")],
	"Amazing Money Machine": ["vs10amm", preload("res://pck/assets/slot/pragmatic/21a.png")],
	"Big Bass Bonanza": ["vs10bbbonanza", preload("res://pck/assets/slot/pragmatic/22a.png")],
	"Big Bass Amazon Xtreme": ["vs10bbextreme", preload("res://pck/assets/slot/pragmatic/23a.png")],
	"Big Bass - Hold & Spinner™": ["vs10bbhas", preload("res://pck/assets/slot/pragmatic/24a.png")],
	"Big Bass Bonanza - Keeping it Reel": ["vs10bbkir", preload("res://pck/assets/slot/pragmatic/25a.png")],
	"Bubble Pop": ["vs10bblpop", preload("res://pck/assets/slot/pragmatic/26a.png")],
	"Book of Aztec King": ["vs10bookazteck", preload("res://pck/assets/slot/pragmatic/27a.png")],
	"Book of Fallen": ["vs10bookfallen", preload("res://pck/assets/slot/pragmatic/28a.png")],
	"Book of Tut": ["vs10bookoftut", preload("res://pck/assets/slot/pragmatic/29a.png")],
	"Christmas Big Bass Bonanza": ["vs10bxmasbnza", preload("res://pck/assets/slot/pragmatic/30a.png")],
	"Chicken Chase": ["vs10chkchase", preload("res://pck/assets/slot/pragmatic/31a.png")],
	"Coffee Wild": ["vs10coffee", preload("res://pck/assets/slot/pragmatic/32a.png")],
	"Cowboys Gold": ["vs10cowgold", preload("res://pck/assets/slot/pragmatic/33a.png")],
	"Crown of Fire™": ["vs10crownfire", preload("res://pck/assets/slot/pragmatic/34a.png")],
	"Queen of Gods": ["vs10egrich", preload("res://pck/assets/slot/pragmatic/35a.png")],
	"Ancient Egypt": ["vs10egypt", preload("res://pck/assets/slot/pragmatic/36a.png")],
	"Ancient Egypt Classic": ["vs10egyptcls", preload("res://pck/assets/slot/pragmatic/37a.png")],
	"Eye of the Storm": ["vs10eyestorm", preload("res://pck/assets/slot/pragmatic/38a.png")],
	"Floating Dragon - Dragon Boat Festival": ["vs10fdrasbf", preload("res://pck/assets/slot/pragmatic/39a.png")],
	"Fire Strike": ["vs10firestrike", preload("res://pck/assets/slot/pragmatic/40a.png")],
	"Fire Strike 2": ["vs10firestrike2", preload("res://pck/assets/slot/pragmatic/41a.png")],
	"Fish Eye": ["vs10fisheye", preload("res://pck/assets/slot/pragmatic/42a.png")],
	"Floating Dragon": ["vs10floatdrg", preload("res://pck/assets/slot/pragmatic/43a.png")],
	"Extra Juicy": ["vs10fruity2", preload("res://pck/assets/slot/pragmatic/44a.png")],
	"Gods of Giza™": ["vs10gizagods", preload("res://pck/assets/slot/pragmatic/45a.png")],
	"Fishin Reels": ["vs10goldfish", preload("res://pck/assets/slot/pragmatic/46a.png")],
	"Jane Hunter and the Mask of Montezuma™": ["vs10jnmntzma", preload("res://pck/assets/slot/pragmatic/47a.png")],
	"Kingdom of The Dead": ["vs10kingofdth", preload("res://pck/assets/slot/pragmatic/48a.png")],
	"Lucky, Grace & Charm": ["vs10luckcharm", preload("res://pck/assets/slot/pragmatic/49a.png")],
	"Madame Destiny": ["vs10madame", preload("res://pck/assets/slot/pragmatic/50a.png")],
	"John Hunter And The Mayan Gods": ["vs10mayangods", preload("res://pck/assets/slot/pragmatic/51a.png")],
	"Magic Money Maze": ["vs10mmm", preload("res://pck/assets/slot/pragmatic/52a.png")],
	"Rise of Giza PowerNudge": ["vs10nudgeit", preload("res://pck/assets/slot/pragmatic/53a.png")],
	"Peak Power": ["vs10powerlines", preload("res://pck/assets/slot/pragmatic/54a.png")],
	"Return of the Dead": ["vs10returndead", preload("res://pck/assets/slot/pragmatic/55a.png")],
	"Gates of Valhalla": ["vs10runes", preload("res://pck/assets/slot/pragmatic/56a.png")],
	"Snakes & Ladders - Snake Eyes": ["vs10snakeeyes", preload("res://pck/assets/slot/pragmatic/57a.png")],
	"Snakes and Ladders Megadice": ["vs10snakeladd", preload("res://pck/assets/slot/pragmatic/58a.png")],
	"Spirit of Adventure": ["vs10spiritadv", preload("res://pck/assets/slot/pragmatic/59a.png")],
	"Star Pirates Code": ["vs10starpirate", preload("res://pck/assets/slot/pragmatic/60a.png")],
	"Three Star Fortune": ["vs10threestar", preload("res://pck/assets/slot/pragmatic/61a.png")],
	"Tic Tac Take": ["vs10tictac", preload("res://pck/assets/slot/pragmatic/62a.png")],
	"Mustang Trail": ["vs10trail", preload("res://pck/assets/slot/pragmatic/63a.png")],
	"John Hunter & the Book of Tut Respin™": ["vs10tut", preload("res://pck/assets/slot/pragmatic/64a.png")],
	"Big Bass Splash": ["vs10txbigbass", preload("res://pck/assets/slot/pragmatic/65a.png")],
	"Vampires vs Wolves": ["vs10vampwolf", preload("res://pck/assets/slot/pragmatic/66a.png")],
	"Mysterious Egypt": ["vs10wildtut", preload("res://pck/assets/slot/pragmatic/67a.png")],
	"Starz Megaways": ["vs117649starz", preload("res://pck/assets/slot/pragmatic/68a.png")],
	"Bigger Bass Bonanza": ["vs12bbb", preload("res://pck/assets/slot/pragmatic/69a.png")],
	"Bigger Bass Blizzard": ["vs12bbbxmas", preload("res://pck/assets/slot/pragmatic/70a.png")],
	"Club Tropicana": ["vs12tropicana", preload("res://pck/assets/slot/pragmatic/71a.png")],
	"Devil's 13": ["vs13g", preload("res://pck/assets/slot/pragmatic/72a.png")],
	"Diamond Strike": ["vs15diamond", preload("res://pck/assets/slot/pragmatic/73a.png")],
	"Fairytale Fortune": ["vs15fairytale", preload("res://pck/assets/slot/pragmatic/74a.png")],
	"Zeus vs Hades - Gods of War": ["vs15godsofwar", preload("res://pck/assets/slot/pragmatic/75a.png")],
	"Drago - Jewels of Fortune": ["vs1600drago", preload("res://pck/assets/slot/pragmatic/76a.png")],
	"Treasure Horse": ["vs18mashang", preload("res://pck/assets/slot/pragmatic/77a.png")],
	"Lucky Dragon Ball": ["vs1ball", preload("res://pck/assets/slot/pragmatic/78a.png")],
	"888 Dragons": ["vs1dragon8", preload("res://pck/assets/slot/pragmatic/79a.png")],
	"Tree of Riches": ["vs1fortunetree", preload("res://pck/assets/slot/pragmatic/80a.png")],
	"Fu Fu Fu": ["vs1fufufu", preload("res://pck/assets/slot/pragmatic/81a.png")],
	"Master Joker": ["vs1masterjoker", preload("res://pck/assets/slot/pragmatic/82a.png")],
	"Money Money Money": ["vs1money", preload("res://pck/assets/slot/pragmatic/83a.png")],
	"Triple Tigers": ["vs1tigers", preload("res://pck/assets/slot/pragmatic/84a.png")],
	"Aladdin and the Sorcerer": ["vs20aladdinsorc", preload("res://pck/assets/slot/pragmatic/85a.png")],
	"Fortune of Giza": ["vs20amuleteg", preload("res://pck/assets/slot/pragmatic/86a.png")],
	"Kingdom of Asgard™": ["vs20asgard", preload("res://pck/assets/slot/pragmatic/87a.png")],
	"Gates of Aztec™": ["vs20aztecgates", preload("res://pck/assets/slot/pragmatic/88a.png")],
	"Wild Beach Party": ["vs20bchprty", preload("res://pck/assets/slot/pragmatic/89a.png")],
	"Fat Panda": ["vs20beefed", preload("res://pck/assets/slot/pragmatic/90a.png")],
	"John Hunter and the Quest for Bermuda Riches": ["vs20bermuda", preload("res://pck/assets/slot/pragmatic/91a.png")],
	"Busy Bees": ["vs20bl", preload("res://pck/assets/slot/pragmatic/92a.png")],
	"Bonanza Gold": ["vs20bonzgold", preload("res://pck/assets/slot/pragmatic/93a.png")],
	"Candy Village": ["vs20candvil", preload("res://pck/assets/slot/pragmatic/94a.png")],
	"Cash Box": ["vs20cashmachine", preload("res://pck/assets/slot/pragmatic/95a.png")],
	"Chicken Drop": ["vs20chickdrop", preload("res://pck/assets/slot/pragmatic/96a.png")],
	"The Great Chicken Escape": ["vs20chicken", preload("res://pck/assets/slot/pragmatic/97a.png")],
	"Cleocatra": ["vs20cleocatra", preload("res://pck/assets/slot/pragmatic/98a.png")],
	"Sweet Powernudge™": ["vs20clspwrndg", preload("res://pck/assets/slot/pragmatic/99a.png")],
	"Sticky Bees": ["vs20clustwild", preload("res://pck/assets/slot/pragmatic/100a.png")],
	"Colossal Cash Zone": ["vs20colcashzone", preload("res://pck/assets/slot/pragmatic/101a.png")],
	"Day of Dead": ["vs20daydead", preload("res://pck/assets/slot/pragmatic/102a.png")],
	"The Dog House": ["vs20doghouse", preload("res://pck/assets/slot/pragmatic/103a.png")],
	"The Dog House Multihold™": ["vs20doghousemh", preload("res://pck/assets/slot/pragmatic/104a.png")],
	"Dragon Hero": ["vs20drgbless", preload("res://pck/assets/slot/pragmatic/105a.png")],
	"Drill that Gold": ["vs20drtgold", preload("res://pck/assets/slot/pragmatic/106a.png")],
	"Hot Pepper™": ["vs20dugems", preload("res://pck/assets/slot/pragmatic/107a.png")],
	"Cyclops Smash": ["vs20earthquake", preload("res://pck/assets/slot/pragmatic/108a.png")],
	"Egyptian Fortunes": ["vs20egypttrs", preload("res://pck/assets/slot/pragmatic/110a.png")],
	"8 Dragons": ["vs20eightdragons", preload("res://pck/assets/slot/pragmatic/111a.png")],
	"Emerald King": ["vs20eking", preload("res://pck/assets/slot/pragmatic/112a.png")],
	"Emerald King Rainbow Road": ["vs20ekingrr", preload("res://pck/assets/slot/pragmatic/113a.png")],
	"Empty the Bank": ["vs20emptybank", preload("res://pck/assets/slot/pragmatic/114a.png")],
	"Excalibur Unleashed": ["vs20excalibur", preload("res://pck/assets/slot/pragmatic/115a.png")],
	"Barn Festival": ["vs20farmfest", preload("res://pck/assets/slot/pragmatic/116a.png")],
	"Fire Hot 20™": ["vs20fh", preload("res://pck/assets/slot/pragmatic/117a.png")],
	"Forge of Olympus": ["vs20forge", preload("res://pck/assets/slot/pragmatic/118a.png")],
	"Fruit Party 2": ["vs20fparty2", preload("res://pck/assets/slot/pragmatic/119a.png")],
	"Fruits of the Amazon™": ["vs20framazon", preload("res://pck/assets/slot/pragmatic/120a.png")],
	"Fruit Party": ["vs20fruitparty", preload("res://pck/assets/slot/pragmatic/121a.png")],
	"Gatot Kaca's Fury™": ["vs20gatotfury", preload("res://pck/assets/slot/pragmatic/123a.png")],
	"Goblin Heist Powernudge": ["vs20gobnudge", preload("res://pck/assets/slot/pragmatic/125a.png")],
	"Lady Godiva": ["vs20godiva", preload("res://pck/assets/slot/pragmatic/126a.png")],
	"Rabbit Garden™": ["vs20goldclust", preload("res://pck/assets/slot/pragmatic/127a.png")],
	"Gems Bonanza": ["vs20goldfever", preload("res://pck/assets/slot/pragmatic/128a.png")],
	"Jungle Gorilla": ["vs20gorilla", preload("res://pck/assets/slot/pragmatic/129a.png")],
	"Hot to Burn Hold and Spin": ["vs20hburnhs", preload("res://pck/assets/slot/pragmatic/130a.png")],
	"Hercules and Pegasus": ["vs20hercpeg", preload("res://pck/assets/slot/pragmatic/131a.png")],
	"Honey Honey Honey": ["vs20honey", preload("res://pck/assets/slot/pragmatic/132a.png")],
	"African Elephant™": ["vs20hotzone", preload("res://pck/assets/slot/pragmatic/133a.png")],
	"Heist for the Golden Nuggets": ["vs20hstgldngt", preload("res://pck/assets/slot/pragmatic/134a.png")],
	"Jewel Rush": ["vs20jewelparty", preload("res://pck/assets/slot/pragmatic/135a.png")],
	"Release the Kraken": ["vs20kraken", preload("res://pck/assets/slot/pragmatic/136a.png")],
	"Release the Kraken 2™": ["vs20kraken2", preload("res://pck/assets/slot/pragmatic/137a.png")],
	"Lamp Of Infinity": ["vs20lampinf", preload("res://pck/assets/slot/pragmatic/138a.png")],
	"vs20lcount": ["vs20lcount", preload("res://pck/assets/slot/pragmatic/139a.png")],
	"Leprechaun Song": ["vs20leprechaun", preload("res://pck/assets/slot/pragmatic/140a.png")],
	"Leprechaun Carol": ["vs20leprexmas", preload("res://pck/assets/slot/pragmatic/141a.png")],
	"Lobster Bob's Crazy Crab Shack": ["vs20lobcrab", preload("res://pck/assets/slot/pragmatic/142a.png")],
	"Pinup Girls™": ["vs20ltng", preload("res://pck/assets/slot/pragmatic/143a.png")],
	"Pub Kings": ["vs20lvlup", preload("res://pck/assets/slot/pragmatic/144a.png")],
	"The Magic Cauldron": ["vs20magicpot", preload("res://pck/assets/slot/pragmatic/145a.png")],
	"Mammoth Gold Megaways™": ["vs20mammoth", preload("res://pck/assets/slot/pragmatic/146a.png")],
	"The Hand of Midas": ["vs20midas", preload("res://pck/assets/slot/pragmatic/147a.png")],
	"Mochimon™": ["vs20mochimon", preload("res://pck/assets/slot/pragmatic/148a.png")],
	"Wild Hop & Drop™": ["vs20mparty", preload("res://pck/assets/slot/pragmatic/149a.png")],
	"Pirate Golden Age™": ["vs20mtreasure", preload("res://pck/assets/slot/pragmatic/150a.png")],
	"Muertos Multiplier Megaways™": ["vs20muertos", preload("res://pck/assets/slot/pragmatic/151a.png")],
	"Clover Gold": ["vs20mustanggld2", preload("res://pck/assets/slot/pragmatic/152a.png")],
	"Jasmine Dreams": ["vs20mvwild", preload("res://pck/assets/slot/pragmatic/153a.png")],
	"Octobeer Fortunes™": ["vs20octobeer", preload("res://pck/assets/slot/pragmatic/154a.png")],
	"Pyramid Bonanza": ["vs20pbonanza", preload("res://pck/assets/slot/pragmatic/156a.png")],
	"Phoenix Forge": ["vs20phoenixf", preload("res://pck/assets/slot/pragmatic/157a.png")],
	"Piggy Bankers": ["vs20piggybank", preload("res://pck/assets/slot/pragmatic/158a.png")],
	"Wild West Duels": ["vs20pistols", preload("res://pck/assets/slot/pragmatic/159a.png")],
	"Santa's Great Gifts™": ["vs20porbs", preload("res://pck/assets/slot/pragmatic/160a.png")],
	"Wisdom of Athena": ["vs20procount", preload("res://pck/assets/slot/pragmatic/161a.png")],
	"Rainbow Gold": ["vs20rainbowg", preload("res://pck/assets/slot/pragmatic/162a.png")],
	"Great Rhino": ["vs20rhino", preload("res://pck/assets/slot/pragmatic/163a.png")],
	"Great Rhino Deluxe": ["vs20rhinoluxe", preload("res://pck/assets/slot/pragmatic/164a.png")],
	"Rock Vegas": ["vs20rockvegas", preload("res://pck/assets/slot/pragmatic/165a.png")],
	"Saiyan Mania": ["vs20saiman", preload("res://pck/assets/slot/pragmatic/166a.png")],
	"Santa": ["vs20santa", preload("res://pck/assets/slot/pragmatic/167a.png")],
	"Santa's Wonderland": ["vs20santawonder", preload("res://pck/assets/slot/pragmatic/168a.png")],
	"Starlight Christmas": ["vs20schristmas", preload("res://pck/assets/slot/pragmatic/170a.png")],
	"Shining Hot 20": ["vs20sh", preload("res://pck/assets/slot/pragmatic/171a.png")],
	"The Knight King™": ["vs20sknights", preload("res://pck/assets/slot/pragmatic/172a.png")],
	"Smugglers Cove": ["vs20smugcove", preload("res://pck/assets/slot/pragmatic/173a.png")],
	"Shield Of Sparta™": ["vs20sparta", preload("res://pck/assets/slot/pragmatic/174a.png")],
	"Spellbinding Mystery": ["vs20splmystery", preload("res://pck/assets/slot/pragmatic/175a.png")],
	"The Great Stick-Up": ["vs20stickysymbol", preload("res://pck/assets/slot/pragmatic/178a.png")],
	"Wild Bison Charge": ["vs20stickywild", preload("res://pck/assets/slot/pragmatic/179a.png")],
	"Monster Superlanche™": ["vs20superlanche", preload("res://pck/assets/slot/pragmatic/181a.png")],
	"Super X": ["vs20superx", preload("res://pck/assets/slot/pragmatic/182a.png")],
	"Sword of Ares™": ["vs20swordofares", preload("res://pck/assets/slot/pragmatic/183a.png")],
	"Cash Elevator": ["vs20terrorv", preload("res://pck/assets/slot/pragmatic/184a.png")],
	"Towering Fortunes™": ["vs20theights", preload("res://pck/assets/slot/pragmatic/185a.png")],
	"Treasure Wild": ["vs20trsbox", preload("res://pck/assets/slot/pragmatic/186a.png")],
	"Black Bull™": ["vs20trswild2", preload("res://pck/assets/slot/pragmatic/187a.png")],
	"The Tweety House": ["vs20tweethouse", preload("res://pck/assets/slot/pragmatic/188a.png")],
	"The Ultimate 5": ["vs20ultim5", preload("res://pck/assets/slot/pragmatic/189a.png")],
	"Down The Rails™": ["vs20underground", preload("res://pck/assets/slot/pragmatic/190a.png")],
	"Vegas Magic": ["vs20vegasmagic", preload("res://pck/assets/slot/pragmatic/191a.png")],
	"Wild Booster": ["vs20wildboost", preload("res://pck/assets/slot/pragmatic/192a.png")],
	"Wildman Super Bonanza": ["vs20wildman", preload("res://pck/assets/slot/pragmatic/193a.png")],
	"3 Buzzing Wilds": ["vs20wildparty", preload("res://pck/assets/slot/pragmatic/194a.png")],
	"Wild Pixies": ["vs20wildpix", preload("res://pck/assets/slot/pragmatic/195a.png")],
	"Greedy Wolf": ["vs20wolfie", preload("res://pck/assets/slot/pragmatic/196a.png")],
	"Christmas Carol Megaways": ["vs20xmascarol", preload("res://pck/assets/slot/pragmatic/197a.png")],
	"Caishen's Cash": ["vs243caishien", preload("res://pck/assets/slot/pragmatic/198a.png")],
	"Raging Bull": ["vs243chargebull", preload("res://pck/assets/slot/pragmatic/199a.png")],
	"Cheeky Emperor™": ["vs243ckemp", preload("res://pck/assets/slot/pragmatic/200a.png")],
	"Dance Party": ["vs243dancingpar", preload("res://pck/assets/slot/pragmatic/201a.png")],
	"Disco Lady": ["vs243discolady", preload("res://pck/assets/slot/pragmatic/202a.png")],
	"Emperor Caishen": ["vs243empcaishen", preload("res://pck/assets/slot/pragmatic/203a.png")],
	"Greek Gods": ["vs243fortseren", preload("res://pck/assets/slot/pragmatic/204a.png")],
	"Caishen's Gold": ["vs243fortune", preload("res://pck/assets/slot/pragmatic/205a.png")],
	"Koi Pond": ["vs243koipond", preload("res://pck/assets/slot/pragmatic/206a.png")],
	"5 Lions": ["vs243lions", preload("res://pck/assets/slot/pragmatic/207a.png")],
	"5 Lions Gold": ["vs243lionsgold", preload("res://pck/assets/slot/pragmatic/208a.png")],
	"Monkey Warrior": ["vs243mwarrior", preload("res://pck/assets/slot/pragmatic/209a.png")],
	"Hellvis Wild": ["vs243nudge4gold", preload("res://pck/assets/slot/pragmatic/210a.png")],
	"Queenie": ["vs243queenie", preload("res://pck/assets/slot/pragmatic/211a.png")],
	"Fire Archer™": ["vs25archer", preload("res://pck/assets/slot/pragmatic/212a.png")],
	"Asgard": ["vs25asgard", preload("res://pck/assets/slot/pragmatic/213a.png")],
	"Aztec King": ["vs25aztecking", preload("res://pck/assets/slot/pragmatic/214a.png")],
	"Book Of Kingdoms": ["vs25bkofkngdm", preload("res://pck/assets/slot/pragmatic/215a.png")],
	"Bomb Bonanza": ["vs25bomb", preload("res://pck/assets/slot/pragmatic/216a.png")],
	"Bounty Gold": ["vs25btygold", preload("res://pck/assets/slot/pragmatic/217a.png")],
	"Bull Fiesta": ["vs25bullfiesta", preload("res://pck/assets/slot/pragmatic/218a.png")],
	"Chilli Heat": ["vs25chilli", preload("res://pck/assets/slot/pragmatic/219a.png")],
	"Cash Patrol": ["vs25copsrobbers", preload("res://pck/assets/slot/pragmatic/220a.png")],
	"Da Vinci's Treasure": ["vs25davinci", preload("res://pck/assets/slot/pragmatic/221a.png")],
	"Dragon Kingdom": ["vs25dragonkingdom", preload("res://pck/assets/slot/pragmatic/222a.png")],
	"Dwarven Gold Deluxe": ["vs25dwarves_new", preload("res://pck/assets/slot/pragmatic/224a.png")],
	"Wild Gladiator": ["vs25gladiator", preload("res://pck/assets/slot/pragmatic/225a.png")],
	"Golden Ox": ["vs25gldox", preload("res://pck/assets/slot/pragmatic/226a.png")],
	"Gold Party": ["vs25goldparty", preload("res://pck/assets/slot/pragmatic/227a.png")],
	"Golden Pig": ["vs25goldpig", preload("res://pck/assets/slot/pragmatic/228a.png")],
	"Gold Rush": ["vs25goldrush", preload("res://pck/assets/slot/pragmatic/229a.png")],
	"Holiday Ride": ["vs25holiday", preload("res://pck/assets/slot/pragmatic/231a.png")],
	"Hot Fiesta": ["vs25hotfiesta", preload("res://pck/assets/slot/pragmatic/232a.png")],
	"Joker King": ["vs25jokerking", preload("res://pck/assets/slot/pragmatic/233a.png")],
	"Joker Race": ["vs25jokrace", preload("res://pck/assets/slot/pragmatic/234a.png")],
	"Journey to the West": ["vs25journey", preload("res://pck/assets/slot/pragmatic/235a.png")],
	"Aztec Blaze™": ["vs25kfruit", preload("res://pck/assets/slot/pragmatic/236a.png")],
	"3 Kingdoms - Battle of Red Cliffs": ["vs25kingdoms", preload("res://pck/assets/slot/pragmatic/237a.png")],
	"Money Mouse": ["vs25mmouse", preload("res://pck/assets/slot/pragmatic/238a.png")],
	"Mustang Gold": ["vs25mustang", preload("res://pck/assets/slot/pragmatic/239a.png")],
	"Lucky New Year": ["vs25newyear", preload("res://pck/assets/slot/pragmatic/240a.png")],
	"Panda's Fortune": ["vs25pandagold", preload("res://pck/assets/slot/pragmatic/241a.png")],
	"Panda Fortune 2": ["vs25pandatemple", preload("res://pck/assets/slot/pragmatic/242a.png")],
	"Peking Luck": ["vs25peking", preload("res://pck/assets/slot/pragmatic/243a.png")],
	"Pyramid King": ["vs25pyramid", preload("res://pck/assets/slot/pragmatic/244a.png")],
	"Heart of Rio": ["vs25rio", preload("res://pck/assets/slot/pragmatic/246a.png")],
	"Reel Banks™": ["vs25rlbank", preload("res://pck/assets/slot/pragmatic/247a.png")],
	"Hot Safari": ["vs25safari", preload("res://pck/assets/slot/pragmatic/248a.png")],
	"Rise of Samurai": ["vs25samurai", preload("res://pck/assets/slot/pragmatic/249a.png")],
	"John Hunter and the Tomb of the Scarab Queen": ["vs25scarabqueen", preload("res://pck/assets/slot/pragmatic/250a.png")],
	"Great Reef": ["vs25sea", preload("res://pck/assets/slot/pragmatic/251a.png")],
	"Secret City Gold™": ["vs25spgldways", preload("res://pck/assets/slot/pragmatic/252a.png")],
	"Knight Hot Spotz": ["vs25spotz", preload("res://pck/assets/slot/pragmatic/253a.png")],
	"The Tiger Warrior": ["vs25tigerwar", preload("res://pck/assets/slot/pragmatic/254a.png")],
	"Lucky New Year - Tiger Treasures": ["vs25tigeryear", preload("res://pck/assets/slot/pragmatic/255a.png")],
	"Vegas Nights": ["vs25vegas", preload("res://pck/assets/slot/pragmatic/256a.png")],
	"Wild Walker": ["vs25walker", preload("res://pck/assets/slot/pragmatic/257a.png")],
	"Wild Spells": ["vs25wildspells", preload("res://pck/assets/slot/pragmatic/258a.png")],
	"Wolf Gold": ["vs25wolfgold", preload("res://pck/assets/slot/pragmatic/259a.png")],
	"Gold Train": ["vs3train", preload("res://pck/assets/slot/pragmatic/260a.png")],
	"Buffalo King": ["vs4096bufking", preload("res://pck/assets/slot/pragmatic/261a.png")],
	"Magician's Secrets": ["vs4096magician", preload("res://pck/assets/slot/pragmatic/263a.png")],
	"Mysterious": ["vs4096mystery", preload("res://pck/assets/slot/pragmatic/264a.png")],
	"Robber Strike": ["vs4096robber", preload("res://pck/assets/slot/pragmatic/265a.png")],
	"Big Juan": ["vs40bigjuan", preload("res://pck/assets/slot/pragmatic/266a.png")],
	"Eye of Cleopatra": ["vs40cleoeye", preload("res://pck/assets/slot/pragmatic/267a.png")],
	"Cosmic Cash": ["vs40cosmiccash", preload("res://pck/assets/slot/pragmatic/268a.png")],
	"Fire Hot 40™": ["vs40firehot", preload("res://pck/assets/slot/pragmatic/269a.png")],
	"Fruit Rainbow": ["vs40frrainbow", preload("res://pck/assets/slot/pragmatic/270a.png")],
	"Hot to Burn Extreme": ["vs40hotburnx", preload("res://pck/assets/slot/pragmatic/271a.png")],
	"The Wild Machine": ["vs40madwheel", preload("res://pck/assets/slot/pragmatic/272a.png")],
	"Pirate Gold": ["vs40pirate", preload("res://pck/assets/slot/pragmatic/273a.png")],
	"Pirate Gold Deluxe": ["vs40pirgold", preload("res://pck/assets/slot/pragmatic/274a.png")],
	"Rise Of Samurai III": ["vs40samurai3", preload("res://pck/assets/slot/pragmatic/275a.png")],
	"Shining Hot 40": ["vs40sh", preload("res://pck/assets/slot/pragmatic/276a.png")],
	"Spartan King": ["vs40spartaking", preload("res://pck/assets/slot/pragmatic/277a.png")],
	"Street Racer": ["vs40streetracer", preload("res://pck/assets/slot/pragmatic/278a.png")],
	"Voodoo Magic": ["vs40voodoo", preload("res://pck/assets/slot/pragmatic/279a.png")],
	"Wild Depths": ["vs40wanderw", preload("res://pck/assets/slot/pragmatic/280a.png")],
	"Wild West Gold": ["vs40wildwest", preload("res://pck/assets/slot/pragmatic/281a.png")],
	"Congo Cash": ["vs432congocash", preload("res://pck/assets/slot/pragmatic/282a.png")],
	"3 Genie Wishes": ["vs50aladdin", preload("res://pck/assets/slot/pragmatic/283a.png")],
	"Lucky Dragons": ["vs50chinesecharms", preload("res://pck/assets/slot/pragmatic/285a.png")],
	"Diamond Cascade": ["vs50dmdcascade", preload("res://pck/assets/slot/pragmatic/286a.png")],
	"Hercules Son of Zeus": ["vs50hercules", preload("res://pck/assets/slot/pragmatic/287a.png")],
	"Kraken's Sky Bounty": ["vs50jucier", preload("res://pck/assets/slot/pragmatic/288a.png")],
	"Juicy Fruits": ["vs50juicyfr", preload("res://pck/assets/slot/pragmatic/289a.png")],
	"Mighty Kong": ["vs50kingkong", preload("res://pck/assets/slot/pragmatic/290a.png")],
	"Might of Ra": ["vs50mightra", preload("res://pck/assets/slot/pragmatic/291a.png")],
	"North Guardians": ["vs50northgard", preload("res://pck/assets/slot/pragmatic/292a.png")],
	"Pixie Wings": ["vs50pixie", preload("res://pck/assets/slot/pragmatic/293a.png")],
	"Safari King": ["vs50safariking", preload("res://pck/assets/slot/pragmatic/294a.png")],
	"Hokkaido Wolf": ["vs576hokkwolf", preload("res://pck/assets/slot/pragmatic/295a.png")],
	"Wild Wild Riches": ["vs576treasures", preload("res://pck/assets/slot/pragmatic/296a.png")],
	"Aztec Gems": ["vs5aztecgems", preload("res://pck/assets/slot/pragmatic/297a.png")],
	"Dragon Hot Hold & Spin": ["vs5drhs", preload("res://pck/assets/slot/pragmatic/299a.png")],
	"Dragon Kingdom - Eyes of Fire": ["vs5drmystery", preload("res://pck/assets/slot/pragmatic/300a.png")],
	"Fire Hot 5™": ["vs5firehot", preload("res://pck/assets/slot/pragmatic/301a.png")],
	"Hot to Burn": ["vs5hotburn", preload("res://pck/assets/slot/pragmatic/302a.png")],
	"Joker's Jewels": ["vs5joker", preload("res://pck/assets/slot/pragmatic/303a.png")],
	"Little Gem": ["vs5littlegem", preload("res://pck/assets/slot/pragmatic/304a.png")],
	"Shining Hot 5": ["vs5sh", preload("res://pck/assets/slot/pragmatic/305a.png")],
	"Super Joker": ["vs5spjoker", preload("res://pck/assets/slot/pragmatic/306a.png")],
	"Striking Hot 5™": ["vs5strh", preload("res://pck/assets/slot/pragmatic/307a.png")],
	"Super 7s": ["vs5super7", preload("res://pck/assets/slot/pragmatic/308a.png")],
	"Triple Dragons": ["vs5trdragons", preload("res://pck/assets/slot/pragmatic/309a.png")],
	"Ultra Hold and Spin": ["vs5ultra", preload("res://pck/assets/slot/pragmatic/310a.png")],
	"Ultra Burn": ["vs5ultrab", preload("res://pck/assets/slot/pragmatic/311a.png")],
	"Aztec Bonanza": ["vs7776aztec", preload("res://pck/assets/slot/pragmatic/314a.png")],
	"Aztec Treasure": ["vs7776secrets", preload("res://pck/assets/slot/pragmatic/315a.png")],
	"Fire 88": ["vs7fire88", preload("res://pck/assets/slot/pragmatic/316a.png")],
	"7 Monkeys": ["vs7monkeys", preload("res://pck/assets/slot/pragmatic/317a.png")],
	"7 Piggies": ["vs7pigs", preload("res://pck/assets/slot/pragmatic/318a.png")],
	"Hockey Attack": ["vs88hockattack", preload("res://pck/assets/slot/pragmatic/319a.png")],
	"Magic Journey": ["vs8magicjourn", preload("res://pck/assets/slot/pragmatic/320a.png")],
	"Aztec Gems Deluxe": ["vs9aztecgemsdx", preload("res://pck/assets/slot/pragmatic/321a.png")],
	"Master Chen's Fortune": ["vs9chen", preload("res://pck/assets/slot/pragmatic/322a.png")],
	"Hot Chilli": ["vs9hotroll", preload("res://pck/assets/slot/pragmatic/323a.png")],
	"Monkey Madness": ["vs9madmonkey", preload("res://pck/assets/slot/pragmatic/324a.png")],
	"Pirates Pub": ["vs9outlaw", preload("res://pck/assets/slot/pragmatic/325a.png")],
	"Piggy Bank Bills": ["vs9piggybank", preload("res://pck/assets/slot/pragmatic/326a.png")],
	"Aztec King Megaways": ["vswaysaztecking", preload("res://pck/assets/slot/pragmatic/327a.png")],
	"Cash Bonanza": ["vswaysbankbonz", preload("res://pck/assets/slot/pragmatic/328a.png")],
	"Big Bass Bonanza Megaways": ["vswaysbbb", preload("res://pck/assets/slot/pragmatic/329a.png")],
	"Big Bass Hold & Spinner Megaways": ["vswaysbbhas", preload("res://pck/assets/slot/pragmatic/330a.png")],
	"Book of Golden Sands™": ["vswaysbook", preload("res://pck/assets/slot/pragmatic/331a.png")],
	"Buffalo King Megaways": ["vswaysbufking", preload("res://pck/assets/slot/pragmatic/332a.png")],
	"Chilli Heat Megaways": ["vswayschilheat", preload("res://pck/assets/slot/pragmatic/333a.png")],
	"vswaysconcoll": ["vswaysconcoll", preload("res://pck/assets/slot/pragmatic/334a.png")],
	"Crystal Caverns Megaways": ["vswayscryscav", preload("res://pck/assets/slot/pragmatic/335a.png")],
	"Elemental Gems Megaways": ["vswayselements", preload("res://pck/assets/slot/pragmatic/337a.png")],
	"Diamonds of Egypt": ["vswayseternity", preload("res://pck/assets/slot/pragmatic/338a.png")],
	"Floating Dragon Hold & Spin Megaways™": ["vswaysfltdrg", preload("res://pck/assets/slot/pragmatic/339a.png")],
	"Frogs & Bugs": ["vswaysfrbugs", preload("res://pck/assets/slot/pragmatic/340a.png")],
	"Spin & Score Megaways™": ["vswaysfrywld", preload("res://pck/assets/slot/pragmatic/341a.png")],
	"Frozen Tropics": ["vswaysftropics", preload("res://pck/assets/slot/pragmatic/342a.png")],
	"Fury of Odin Megaways™ ": ["vswaysfuryodin", preload("res://pck/assets/slot/pragmatic/343a.png")],
	"Power of Thor Megaways": ["vswayshammthor", preload("res://pck/assets/slot/pragmatic/344a.png")],
	"Star Bounty": ["vswayshive", preload("res://pck/assets/slot/pragmatic/345a.png")],
	"Gold Oasis": ["vswaysincwnd", preload("res://pck/assets/slot/pragmatic/346a.png")],
	"Tropical Tiki": ["vswaysjkrdrop", preload("res://pck/assets/slot/pragmatic/347a.png")],
	"Lucky Lightning": ["vswayslight", preload("res://pck/assets/slot/pragmatic/348a.png")],
	"Legend of Heroes Megaways": ["vswayslofhero", preload("res://pck/assets/slot/pragmatic/350a.png")],
	"Lucky Fishing Megaways™": ["vswaysluckyfish", preload("res://pck/assets/slot/pragmatic/351a.png")],
	"Madame Destiny Megaways": ["vswaysmadame", preload("res://pck/assets/slot/pragmatic/352a.png")],
	"3 Dancing Monkeys™": ["vswaysmonkey", preload("res://pck/assets/slot/pragmatic/353a.png")],
	"Mystery Of The Orient": ["vswaysmorient", preload("res://pck/assets/slot/pragmatic/354a.png")],
	"Old Gold Miner Megaways": ["vswaysoldminer", preload("res://pck/assets/slot/pragmatic/355a.png")],
	"PIZZA! PIZZA? PIZZA!™": ["vswayspizza", preload("res://pck/assets/slot/pragmatic/356a.png")],
	"Power of Merlin Megaways": ["vswayspowzeus", preload("res://pck/assets/slot/pragmatic/357a.png")],
	"The Red Queen™": ["vswaysredqueen", preload("res://pck/assets/slot/pragmatic/359a.png")],
	"Great Rhino Megaways": ["vswaysrhino", preload("res://pck/assets/slot/pragmatic/360a.png")],
	"Rocket Blast Megaways": ["vswaysrockblst", preload("res://pck/assets/slot/pragmatic/361a.png")],
	"Wild Celebrity Bus Megaways™": ["vswaysrsm", preload("res://pck/assets/slot/pragmatic/362a.png")],
	"Rise of Samurai Megaways": ["vswayssamurai", preload("res://pck/assets/slot/pragmatic/363a.png")],
	"Candy Stars™": ["vswaysstrwild", preload("res://pck/assets/slot/pragmatic/364a.png")],
	"Cowboy Coins™": ["vswaysultrcoin", preload("res://pck/assets/slot/pragmatic/365a.png")],
	"Curse of the Werewolf Megaways": ["vswayswerewolf", preload("res://pck/assets/slot/pragmatic/366a.png")],
	"Mystic Chief": ["vswayswest", preload("res://pck/assets/slot/pragmatic/367a.png")],
	"Wild West Gold Megaways": ["vswayswildwest", preload("res://pck/assets/slot/pragmatic/368a.png")],
	"Wild Wild Bananas™": ["vswayswwhex", preload("res://pck/assets/slot/pragmatic/369a.png")],
	"Wild Wild Riches Megaways": ["vswayswwriches", preload("res://pck/assets/slot/pragmatic/370a.png")],
	"Extra Juicy Megaways": ["vswaysxjuicy", preload("res://pck/assets/slot/pragmatic/371a.png")],
	"Yum Yum Powerways": ["vswaysyumyum", preload("res://pck/assets/slot/pragmatic/372a.png")],
	"Zombie Carnival": ["vswayszombcarn", preload("res://pck/assets/slot/pragmatic/373a.png")]
	
}

var slot_textures = []

onready var slot_containers = [
	
	$Slot_container1/p1,
	$Slot_container2/p2,
	$Slot_container3/p3,
	$Slot_container4/p4,
	$Slot_container5/p5,
	$Slot_container6/p6,
	$Slot_container7/p7,
	$Slot_container8/p8,
	$Slot_container9/p9,
	$Slot_container10/p10,
	$Slot_container11/p11,
	$Slot_container12/p12,
	$Slot_container13/p13,
	$Slot_container14/p14,
	$Slot_container15/p15,
	$Slot_container16/p16,
	$Slot_container17/p17,
	$Slot_container18/p18,
	$Slot_container19/p19,
	$Slot_container20/p20,
	$Slot_container21/p21,
	$Slot_container22/p22,
	$Slot_container23/p23,
	$Slot_container24/p24,
	$Slot_container25/p25,
	$Slot_container26/p26,
	$Slot_container27/p27,
	$Slot_container28/p28,
	$Slot_container29/p29,
	$Slot_container30/p30,
	$Slot_container31/p31,
	$Slot_container32/p32,
	$Slot_container33/p33,
	$Slot_container34/p34,
	$Slot_container35/p35,
	$Slot_container36/p36
	
]

#func _load_profile_textures():
#	for i in range(373):
#		var path = "res://pck/assets/slot/pragmatic/" + str(i+1) + "a.png"
#		var texture = load(path)
#		slot_textures.append(texture)
#
#	# Apply textures to slots in each container
#	var key_index = 0
#	for slot_container in slot_containers:
#		var slots = slot_container.get_children()
#		var slot_count = 0
#
#		for a in range(key_index, min(key_index + 10, slot_textures.size())):
#			var slot = slots[slot_count]
#			if slot is TextureButton:
#				slot.texture_normal = slot_textures[a]
#				slot_count += 1
#
#		key_index += 10
#
#	var slot38 = $Slot_container38/p38.get_children()
#	var count38 = 0
#	for b in range(370, min(373, slot_textures.size())):
#		var slot_child = slot38[count38]
#		if slot_child is TextureButton:
#			slot_child.texture_normal = slot_textures[b]
#			count38 += 1


func _load_name_from_json():
	var keys_array = PRAGMATIC_LIST.keys()
	
	var key_index = 0
	for slot_container in slot_containers:
		var slots = slot_container.get_children()
		var slot_count = 0
		
		for i in range(key_index, min(key_index + 10, keys_array.size())):
			var slot = slots[slot_count]
			var key = keys_array[i]
			slot.set_name(str(key))
			slot.connect("pressed", self, "_on_game_pressed", [slot])
			if slot is TextureButton:
				slot.texture_normal = PRAGMATIC_LIST[key][1]
			slot_count += 1
		
		key_index += 10
		
	
	var slot37 = $Slot_container37/p37.get_children()
	var count37 = 0
	for vi in range(360, min(364, keys_array.size())):
		var slot = slot37[count37]  
		var key = keys_array[vi]
		slot.set_name(str(key))
		slot.connect("pressed", self, "_on_game_pressed", [slot])
		if slot is TextureButton:
				slot.texture_normal = PRAGMATIC_LIST[key][1]
		count37 += 1

func _ready():
	# For Slot Animation
	$Slot_Animation.play("RESET")
	
	# For Slot Slider Buttons
	$RightButtons/Right.connect("pressed", self, "Right_Button_Pressed", [Slot_Page])
	$LeftButtons/Left.connect("pressed", self, "Left_Button_Pressed", [Slot_Page])
	
	$LeftButtons/Left.hide()
	
	# Waiting For Websocket Connection
	$Backdrop.show()
	_disabled_buttons()
	print("Show")
	
	if $Setting/SliderMusic.value == 0:
		$"/root/bgm".volume_db =  $Setting/SliderMusic.value
	else:
		$"/root/bgm".volume_db += 45
	
	var url = $"/root/Config".config.account_url + "user_info?id=" + $"/root/Config".config.user.id
	var http = HTTPRequest.new()
	add_child(http)
	http.timeout = 5
	http.connect("request_completed",self,"_update_info")
	http.request(url)
	
#	_load_profile_textures()
	
	_load_name_from_json()
	
	# For Implementing Web Socket
	_connect_websocket()


func _connect_websocket():
	_client.connect("connection_closed", self, "_on_connection_closed")
	_client.connect("connection_error", self, "_on_connection_error")
	_client.connect("connection_established", self, "_on_connected")
	_client.connect("data_received", self, "_on_data")
	
	var err = _client.connect_to_url(websocket_url)
	if err != OK:
		print("Unable to Connect")
		set_process(false)
		$"/root/bgm".volume_db = -50
		LoadingScript.load_scene(self,"res://pck/scenes/slot_provider.tscn")


func _process(delta):
	_client.poll()
#	print(_client.get_connection_status())


func _on_connection_closed(was_clean = false):
	print("Websocket Connection Closed, clean : ", was_clean)
	set_process(false)

func _on_connection_error():
	print("Websocket Connection Error")

# Sending Data request to Web Socket
func _on_connected(proto = ""):
	# Send message to the WebSocket based on the stateForSecond
	print("Connection_Successful with Protocol : ", proto)
	
	var message = {
		"uniquekey": Config.UNIQUE,
		"username": Config.config.user.username,
		"sessionFor": "SECOND",
		"stateForFirst": "",
		"stateForSecond": "STATE_CONNECT",
		"message": ""
	}
	print("This is on connected Message : ", message)
	_send(message)
	
	$Websocket_timer.start()
	
#	$Backdrop.hide()
#	_enabled_buttons()
#	print("hide")


func _on_data():
	var message = _client.get_peer(1).get_packet().get_string_from_utf8()
	print("Received data from Server:", message)
	var obj = JSON.parse(message)
	var res = obj.result
	print("On data Respond after json parsing : ", res)
	
	# Handling different states
	match res.stateForFirst:
		
		"STATE_CONNECT":
			
			match res.stateForSecond:
				"STATE_CONNECT":
					print("Client has been Dinnected")
				"STATE_READY":
					$Backdrop.hide()
					_enabled_buttons()
				"STATE_PLAY":
					$Backdrop.show()
					_disabled_buttons()
				"STATE_DISCONNECT":
					print("Client has been Disconnected")
				"STATE_EXIT":
					$Timer.start()
					
		"STATE_READY":
			$Websocket_timer.stop()
			$Backdrop.hide()
			_enabled_buttons()
			print("hide")
			balance_update()
			print("READY TO GO TO SLOTTTTTTTTTTTTTTTTTTT!!!!")
			match res.stateForSecond:
				"STATE_CONNECT":
					print("Client has been Dinnected")
				"STATE_READY":
					$Backdrop.hide()
					_enabled_buttons()
					if $Setting/SliderMusic.value == 0:
						$"/root/bgm".volume_db =  $Setting/SliderMusic.value
					else:
						$"/root/bgm".volume_db += 45
				"STATE_PLAY":
					$Backdrop.show()
					_disabled_buttons()
				"STATE_DISCONNECT":
					print("Client has been Disconnected")
				"STATE_EXIT":
					$Timer.start()
			
		"STATE_PLAY":
			
			print("State_play")
			match res.stateForSecond:
				"STATE_CONNECT":
					print("Client has been Dinnected")
				"STATE_READY":
					$Backdrop.hide()
					_enabled_buttons()
				"STATE_PLAY":
					$Backdrop.show()
					_disabled_buttons()
				"STATE_DISCONNECT":
					print("Client has been Disconnected")
				"STATE_EXIT":
					$Timer.start()
			
		"STATE_DISCONNECT":
			
			print("State_disconnect")
			match res.stateForSecond:
				"STATE_CONNECT":
					print("Client has been Dinnected")
				"STATE_READY":
					$Backdrop.hide()
					_enabled_buttons()
				"STATE_PLAY":
					$Backdrop.show()
					_disabled_buttons()
				"STATE_DISCONNECT":
					print("Client has been Disconnected")
				"STATE_EXIT":
					$Timer.start()
			
		"STATE_EXIT":
			
			print("state_exit")
			match res.stateForSecond:
				"STATE_CONNECT":
					print("Client has been Dinnected")
				"STATE_READY":
					$Backdrop.hide()
					_enabled_buttons()
				"STATE_PLAY":
					$Backdrop.show()
					_disabled_buttons()
				"STATE_DISCONNECT":
					print("Client has been Disconnected")
				"STATE_EXIT":
					$Timer.start()
					
		"":
			
			print("Legit Disconnected")
			match res.stateForSecond:
				"STATE_CONNECT":
					print("Client has been Dinnected")
				"STATE_READY":
					$Backdrop.hide()
					_enabled_buttons()
				"STATE_PLAY":
					$Backdrop.show()
					_disabled_buttons()
				"STATE_DISCONNECT":
					print("Client has been Disconnected")
				"STATE_EXIT":
					print("Exit Slot Game!!!!!!!!!!!!!!!!!!!!")
			

func _send(data):
	var json = JSON.print(data)
	print("From client --- " + json)
#	var success = _client.get_peer(1).put_packet(json.to_utf8())
	var peer = _client.get_peer(1)
	
	# Set the write mode to WebSocketPeer.WRITE_MODE_TEXT
	peer.set_write_mode(WebSocketPeer.WRITE_MODE_TEXT)
	
	# Convert the JSON string to UTF-8 and send it as a text packet
	var data_utf8 = json.to_utf8()
	var success = peer.put_packet(data_utf8)
	
	if success != OK:
		print("Failed to send data.")
	else:
		print("Data Has Been Sent Successfully")


func _update_info(result, response_code, headers, body):
	print("This is Jili Respond code : ", response_code)
	if response_code != 200:
		$"/root/bgm".volume_db = -50
		LoadingScript.load_scene(self, "res://start/conn_error.tscn")
	else:
		var json_parse_result = JSON.parse(body.get_string_from_utf8())
		if json_parse_result.error != OK:
			print("Error: JSON parsing failed -", json_parse_result.error)
		else:
			var respond = json_parse_result.result
#			var respond = JSON.parse(body.get_string_from_utf8()).result
			balance = respond.balance
			$Balance/Label.text = comma_sep(respond.balance)


func comma_sep(number):
	var string = str(number)
	var mod = string.length() % 3
	var res = ""
	for i in range(0, string.length()):
		if i != 0 && i % 3 == mod:
			res += ","
		res += string[i]
	return res

func on_balance_request_completed(result, response_code, headers, body):
	var json_result = JSON.parse(body.get_string_from_utf8()).result
	$Balance/Label.text = comma_sep(json_result["balance"])

func balance_update():
	var http = HTTPRequest.new()
	var url = "http://redboxmm.tech:8081/acrf-qarava-slot/api/slotuserconnect/getuserbalance/"+$"/root/Config".config.user.username
	add_child(http)
	http.connect("request_completed",self,"on_balance_request_completed")
	http.request(url)


func _on_Exit_pressed():
	isExit = true
	
	var message = {
		"uniquekey": Config.UNIQUE,
		"username": Config.config.user.username,
		"sessionFor": "SECOND",
		"stateForFirst": "",
		"stateForSecond": "STATE_DISCONNECT",
		"message": ""
	}
	print("This is on Exit Message : ", message)
	_send(message)
	
	$Timer.start()
#	# For Music
#	$"/root/bgm".volume_db = -50
#	LoadingScript.load_scene(self,"res://pck/scenes/slot_provider.tscn")

func _on_game_pressed(key_name):
	
	$Backdrop.show()
	_disabled_buttons()
#
#	isPlaying = true
	# For Music
	$"/root/bgm".volume_db = -50
	
	var game_name = key_name.name
	var accesskey = PRAGMATIC_LIST[game_name][0]
	
	print(game_name,",",accesskey)
	
	var postman_url = "http://redboxmm.tech:8081/acrf-qarava-slot/api/slotplayconnect/getgamelink"

	var data = {
	"accesskey": "",
	"gameProvider": "PRAGMATIC",
	"lang": "en",
	"game": accesskey,
	"gameName": game_name,
	"isMobile": Config.config["web"]["isMobile"],
	"redirectLink": "",
	"type": Config.config["web"]["type"],
	"name": "",
	"session": "",
	"provider": "SML99",
	"username": $"/root/Config".config.user.username,
	"beforeBalance": balance,
	"amount": 0,
	"afterBalance": 0,
	"raction": "",
	"rdealId": "",
	"rproviderName": "",
	"rremark": ""
}
	var headers = ["Content-Type: application/json"]
	var http = HTTPRequest.new()
	add_child(http)
	var body = JSON.print(data)
	print("THis is BOdy : ", body)
	print(http.is_connected("request_completed",self,"on_body_request_completed"))
	if http.is_connected("request_completed",self,"on_body_request_completed"):
		http.disconnect("request_completed",self,"on_body_request_completed")
	http.connect("request_completed",self,"on_body_request_completed")
	http.request(postman_url,headers,false,HTTPClient.METHOD_POST,body)
	
func on_body_request_completed(result, response_code, headers, body):
	var json_result = JSON.parse(body.get_string_from_utf8()).result
	print("This is Respond Jason Result : ", json_result)
	Config.slot_url = json_result["url"]
	print("THis is slot_link : ", Config.slot_url)
#	OS.shell_open(Config.slot_url)
	
	var message = {
		"uniquekey": Config.UNIQUE,
		"username": Config.config.user.username,
		"sessionFor": "SECOND",
		"stateForFirst": "",
		"stateForSecond": "STATE_PLAY",
		"message": Config.slot_url
	}
	print("This is on Slot pressed Message : ", message)
	_send(message)



func _on_Timer_timeout():
	# For Music
	$"/root/bgm".volume_db = -50
	LoadingScript.load_scene(self,"res://pck/scenes/slot_provider.tscn")

func _disabled_buttons():
	$Exit.disabled = true
	
	for container in slot_containers:
		var slots = container.get_children()
		for slot in slots:
			if slot is TextureButton:  
				slot.disabled = true
				
	var slot38 = $Slot_container37/p37.get_children()
	for a in range(slot38.size()):
		var slot = slot38[a]
		if slot is TextureButton:
			slot.disabled = true

func _enabled_buttons():
	$Exit.disabled = false
	
	for container in slot_containers:
		var slots = container.get_children()
		for slot in slots:
			if slot is TextureButton:  
				slot.disabled = false
				
	var slot38 = $Slot_container37/p37.get_children()
	for a in range(slot38.size()):
		var slot = slot38[a]
		if slot is TextureButton:
			slot.disabled = false


func _on_Websocket_timer_timeout():
	$"/root/bgm".volume_db = -50
	$Backdrop.hide()
	LoadingScript.load_scene(self,"res://pck/scenes/slot_provider.tscn")

#func disableButtons(names):
#	for i in $RightButtons.get_children():
#		if names.find(i.name) != -1:
#			i.disabled = false
#			i.show()
#		else:
#			i.disabled = true
#			i.hide()
#
#
#	for j in $LeftButtons.get_children():
#		if names.find(j.name) != -1:
#			j.disabled = false
#			j.show()
#		else:
#			j.disabled = true
#			j.hide()

func Right_Button_Pressed(slot_page_no):
	if can_press == true:
		can_press = false
		if slot_page_no != Slot_Page:
			slot_page_no = Slot_Page
		var page = str(int(slot_page_no),"to",int(slot_page_no + 1))
		print("Animation: ",page)
		$Slot_Animation.play(page)
		$Cooldown.start()
		Slot_Page += 1
	
func Left_Button_Pressed(slot_page_no):
	if can_press == true:
		can_press = false
		if slot_page_no != Slot_Page:
			slot_page_no = Slot_Page
		var page = str(int(slot_page_no),"to",int(slot_page_no - 1))
		print("Animation: ",page)
		$Slot_Animation.play(page)
		$Cooldown.start()
		Slot_Page -= 1

func _on_Slot_Animation_animation_finished(anim_name):
	match anim_name:
		"2to1":
			$LeftButtons/Left.hide()
			
		"36to37":
			$RightButtons/Right.hide()
			
		"1to2":
			$LeftButtons/Left.show()
			
		"37to36":
			$RightButtons/Right.show()



func _on_Cooldown_timeout():
	can_press = true
