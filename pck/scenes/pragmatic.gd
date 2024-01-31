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
	
	"Baccarat": "bca",
	"Multihand Blackjack": "bjma",
	"American Blackjack": "bjmb",
	"Dragon Bonus Baccarat": "bnadvanced",
	"Dragon Tiger": "bndt",
	"Irish Charms": "cs3irishcharms",
	"Diamonds are Forever 3 Lines": "cs3w",
	"Money Roll": "cs5moneyroll",
	"888 Gold": "cs5triple8gold",
	"Roulette": "rla",
	"Fire Hot 100™": "vs100firehot",
	"Shining Hot 100": "vs100sh",
	"Jade Butterfly": "vs1024butterfly",
	"The Dragon Tiger": "vs1024dtiger",
	"Gorilla Mayhem™": "vs1024gmayhem",
	"5 Lions Dance": "vs1024lionsd",
	"Mahjong Panda": "vs1024mahjpanda",
	"Mahjong Wins": "vs1024mahjwins",
	"Moonshot™": "vs1024moonsh",
	"Temujin Treasures": "vs1024temuj",
	"Amazing Money Machine": "vs10amm",
	"Big Bass Bonanza": "vs10bbbonanza",
	"Big Bass Amazon Xtreme": "vs10bbextreme",
	"Big Bass - Hold & Spinner™": "vs10bbhas",
	"Big Bass Bonanza - Keeping it Reel": "vs10bbkir",
	"Bubble Pop": "vs10bblpop",
	"Book of Aztec King": "vs10bookazteck",
	"Book of Fallen": "vs10bookfallen",
	"Book of Tut": "vs10bookoftut",
	"Christmas Big Bass Bonanza": "vs10bxmasbnza",
	"Chicken Chase": "vs10chkchase",
	"Coffee Wild": "vs10coffee",
	"Cowboys Gold": "vs10cowgold",
	"Crown of Fire™": "vs10crownfire",
	"Queen of Gods": "vs10egrich",
	"Ancient Egypt": "vs10egypt",
	"Ancient Egypt Classic": "vs10egyptcls",
	"Eye of the Storm": "vs10eyestorm",
	"Floating Dragon - Dragon Boat Festival": "vs10fdrasbf",
	"Fire Strike": "vs10firestrike",
	"Fire Strike 2": "vs10firestrike2",
	"Fish Eye": "vs10fisheye",
	"Floating Dragon": "vs10floatdrg",
	"Extra Juicy": "vs10fruity2",
	"Gods of Giza™": "vs10gizagods",
	"Fishin Reels": "vs10goldfish",
	"Jane Hunter and the Mask of Montezuma™": "vs10jnmntzma",
	"Kingdom of The Dead": "vs10kingofdth",
	"Lucky, Grace & Charm": "vs10luckcharm",
	"Madame Destiny": "vs10madame",
	"John Hunter And The Mayan Gods": "vs10mayangods",
	"Magic Money Maze": "vs10mmm",
	"Rise of Giza PowerNudge": "vs10nudgeit",
	"Peak Power": "vs10powerlines",
	"Return of the Dead": "vs10returndead",
	"Gates of Valhalla": "vs10runes",
	"Snakes & Ladders - Snake Eyes": "vs10snakeeyes",
	"Snakes and Ladders Megadice": "vs10snakeladd",
	"Spirit of Adventure": "vs10spiritadv",
	"Star Pirates Code": "vs10starpirate",
	"Three Star Fortune": "vs10threestar",
	"Tic Tac Take": "vs10tictac",
	"Mustang Trail": "vs10trail",
	"John Hunter & the Book of Tut Respin™": "vs10tut",
	"Big Bass Splash": "vs10txbigbass",
	"Vampires vs Wolves": "vs10vampwolf",
	"Mysterious Egypt": "vs10wildtut",
	"Starz Megaways": "vs117649starz",
	"Bigger Bass Bonanza": "vs12bbb",
	"Bigger Bass Blizzard": "vs12bbbxmas",
	"Club Tropicana": "vs12tropicana",
	"Devil's 13": "vs13g",
	"Diamond Strike": "vs15diamond",
	"Fairytale Fortune": "vs15fairytale",
	"Zeus vs Hades - Gods of War": "vs15godsofwar",
	"Drago - Jewels of Fortune": "vs1600drago",
	"Treasure Horse": "vs18mashang",
	"Lucky Dragon Ball": "vs1ball",
	"888 Dragons": "vs1dragon8",
	"Tree of Riches": "vs1fortunetree",
	"Fu Fu Fu": "vs1fufufu",
	"Master Joker": "vs1masterjoker",
	"Money Money Money": "vs1money",
	"Triple Tigers": "vs1tigers",
	"Aladdin and the Sorcerer": "vs20aladdinsorc",
	"Fortune of Giza": "vs20amuleteg",
	"Kingdom of Asgard™": "vs20asgard",
	"Gates of Aztec™": "vs20aztecgates",
	"Wild Beach Party": "vs20bchprty",
	"Fat Panda": "vs20beefed",
	"John Hunter and the Quest for Bermuda Riches": "vs20bermuda",
	"Busy Bees": "vs20bl",
	"Bonanza Gold": "vs20bonzgold",
	"Candy Village": "vs20candvil",
	"Cash Box": "vs20cashmachine",
	"Chicken Drop": "vs20chickdrop",
	"The Great Chicken Escape": "vs20chicken",
	"Cleocatra": "vs20cleocatra",
	"Sweet Powernudge™": "vs20clspwrndg",
	"Sticky Bees": "vs20clustwild",
	"Colossal Cash Zone": "vs20colcashzone",
	"Day of Dead": "vs20daydead",
	"The Dog House": "vs20doghouse",
	"The Dog House Multihold™": "vs20doghousemh",
	"Dragon Hero": "vs20drgbless",
	"Drill that Gold": "vs20drtgold",
	"Hot Pepper™": "vs20dugems",
	"Cyclops Smash": "vs20earthquake",
	"Tales of Egypt": "vs20egypt",
	"Egyptian Fortunes": "vs20egypttrs",
	"8 Dragons": "vs20eightdragons",
	"Emerald King": "vs20eking",
	"Emerald King Rainbow Road": "vs20ekingrr",
	"Empty the Bank": "vs20emptybank",
	"Excalibur Unleashed": "vs20excalibur",
	"Barn Festival": "vs20farmfest",
	"Fire Hot 20™": "vs20fh",
	"Forge of Olympus": "vs20forge",
	"Fruit Party 2": "vs20fparty2",
	"Fruits of the Amazon™": "vs20framazon",
	"Fruit Party": "vs20fruitparty",
	"Sweet Bonanza": "vs20fruitsw",
	"Gatot Kaca's Fury™": "vs20gatotfury",
	"Gates of Gatot Kaca": "vs20gatotgates",
	"Goblin Heist Powernudge": "vs20gobnudge",
	"Lady Godiva": "vs20godiva",
	"Rabbit Garden™": "vs20goldclust",
	"Gems Bonanza": "vs20goldfever",
	"Jungle Gorilla": "vs20gorilla",
	"Hot to Burn Hold and Spin": "vs20hburnhs",
	"Hercules and Pegasus": "vs20hercpeg",
	"Honey Honey Honey": "vs20honey",
	"African Elephant™": "vs20hotzone",
	"Heist for the Golden Nuggets": "vs20hstgldngt",
	"Jewel Rush": "vs20jewelparty",
	"Release the Kraken": "vs20kraken",
	"Release the Kraken 2™": "vs20kraken2",
	"Lamp Of Infinity": "vs20lampinf",
	"vs20lcount": "vs20lcount",
	"Leprechaun Song": "vs20leprechaun",
	"Leprechaun Carol": "vs20leprexmas",
	"Lobster Bob's Crazy Crab Shack": "vs20lobcrab",
	"Pinup Girls™": "vs20ltng",
	"Pub Kings": "vs20lvlup",
	"The Magic Cauldron": "vs20magicpot",
	"Mammoth Gold Megaways™": "vs20mammoth",
	"The Hand of Midas": "vs20midas",
	"Mochimon™": "vs20mochimon",
	"Wild Hop & Drop™": "vs20mparty",
	"Pirate Golden Age™": "vs20mtreasure",
	"Muertos Multiplier Megaways™": "vs20muertos",
	"Clover Gold": "vs20mustanggld2",
	"Jasmine Dreams": "vs20mvwild",
	"Octobeer Fortunes™": "vs20octobeer",
	"Gates of Olympus": "vs20olympgate",
	"Pyramid Bonanza": "vs20pbonanza",
	"Phoenix Forge": "vs20phoenixf",
	"Piggy Bankers": "vs20piggybank",
	"Wild West Duels": "vs20pistols",
	"Santa's Great Gifts™": "vs20porbs",
	"Wisdom of Athena": "vs20procount",
	"Rainbow Gold": "vs20rainbowg",
	"Great Rhino": "vs20rhino",
	"Great Rhino Deluxe": "vs20rhinoluxe",
	"Rock Vegas": "vs20rockvegas",
	"Saiyan Mania": "vs20saiman",
	"Santa": "vs20santa",
	"Santa's Wonderland": "vs20santawonder",
	"Sweet Bonanza Xmas": "vs20sbxmas",
	"Starlight Christmas": "vs20schristmas",
	"Shining Hot 20": "vs20sh",
	"The Knight King™": "vs20sknights",
	"Smugglers Cove": "vs20smugcove",
	"Shield Of Sparta™": "vs20sparta",
	"Spellbinding Mystery": "vs20splmystery",
	"Starlight Princess": "vs20starlight",
	"Starlight Princess 1000": "vs20starlightx",
	"The Great Stick-Up": "vs20stickysymbol",
	"Wild Bison Charge": "vs20stickywild",
	"Sugar Rush": "vs20sugarrush",
	"Monster Superlanche™": "vs20superlanche",
	"Super X": "vs20superx",
	"Sword of Ares™": "vs20swordofares",
	"Cash Elevator": "vs20terrorv",
	"Towering Fortunes™": "vs20theights",
	"Treasure Wild": "vs20trsbox",
	"Black Bull™": "vs20trswild2",
	"The Tweety House": "vs20tweethouse",
	"The Ultimate 5": "vs20ultim5",
	"Down The Rails™": "vs20underground",
	"Vegas Magic": "vs20vegasmagic",
	"Wild Booster": "vs20wildboost",
	"Wildman Super Bonanza": "vs20wildman",
	"3 Buzzing Wilds": "vs20wildparty",
	"Wild Pixies": "vs20wildpix",
	"Greedy Wolf": "vs20wolfie",
	"Christmas Carol Megaways": "vs20xmascarol",
	"Caishen's Cash": "vs243caishien",
	"Raging Bull": "vs243chargebull",
	"Cheeky Emperor™": "vs243ckemp",
	"Dance Party": "vs243dancingpar",
	"Disco Lady": "vs243discolady",
	"Emperor Caishen": "vs243empcaishen",
	"Greek Gods": "vs243fortseren",
	"Caishen's Gold": "vs243fortune",
	"Koi Pond": "vs243koipond",
	"5 Lions": "vs243lions",
	"5 Lions Gold": "vs243lionsgold",
	"Monkey Warrior": "vs243mwarrior",
	"Hellvis Wild": "vs243nudge4gold",
	"Queenie": "vs243queenie",
	"Fire Archer™": "vs25archer",
	"Asgard": "vs25asgard",
	"Aztec King": "vs25aztecking",
	"Book Of Kingdoms": "vs25bkofkngdm",
	"Bomb Bonanza": "vs25bomb",
	"Bounty Gold": "vs25btygold",
	"Bull Fiesta": "vs25bullfiesta",
	"Chilli Heat": "vs25chilli",
	"Cash Patrol": "vs25copsrobbers",
	"Da Vinci's Treasure": "vs25davinci",
	"Dragon Kingdom": "vs25dragonkingdom",
	"Dwarven Gold": "vs25dwarves",
	"Dwarven Gold Deluxe": "vs25dwarves_new",
	"Wild Gladiator": "vs25gladiator",
	"Golden Ox": "vs25gldox",
	"Gold Party": "vs25goldparty",
	"Golden Pig": "vs25goldpig",
	"Gold Rush": "vs25goldrush",
	"Fruity Blast": "vs25h",
	"Holiday Ride": "vs25holiday",
	"Hot Fiesta": "vs25hotfiesta",
	"Joker King": "vs25jokerking",
	"Joker Race": "vs25jokrace",
	"Journey to the West": "vs25journey",
	"Aztec Blaze™": "vs25kfruit",
	"3 Kingdoms - Battle of Red Cliffs": "vs25kingdoms",
	"Money Mouse": "vs25mmouse",
	"Mustang Gold": "vs25mustang",
	"Lucky New Year": "vs25newyear",
	"Panda's Fortune": "vs25pandagold",
	"Panda Fortune 2": "vs25pandatemple",
	"Peking Luck": "vs25peking",
	"Pyramid King": "vs25pyramid",
	"Queen of Gold": "vs25queenofgold",
	"Heart of Rio": "vs25rio",
	"Reel Banks™": "vs25rlbank",
	"Hot Safari": "vs25safari",
	"Rise of Samurai": "vs25samurai",
	"John Hunter and the Tomb of the Scarab Queen": "vs25scarabqueen",
	"Great Reef": "vs25sea",
	"Secret City Gold™": "vs25spgldways",
	"Knight Hot Spotz": "vs25spotz",
	"The Tiger Warrior": "vs25tigerwar",
	"Lucky New Year - Tiger Treasures": "vs25tigeryear",
	"Vegas Nights": "vs25vegas",
	"Wild Walker": "vs25walker",
	"Wild Spells": "vs25wildspells",
	"Wolf Gold": "vs25wolfgold",
	"Gold Train": "vs3train",
	"Buffalo King": "vs4096bufking",
	"Jurassic Giants": "vs4096jurassic",
	"Magician's Secrets": "vs4096magician",
	"Mysterious": "vs4096mystery",
	"Robber Strike": "vs4096robber",
	"Big Juan": "vs40bigjuan",
	"Eye of Cleopatra": "vs40cleoeye",
	"Cosmic Cash": "vs40cosmiccash",
	"Fire Hot 40™": "vs40firehot",
	"Fruit Rainbow": "vs40frrainbow",
	"Hot to Burn Extreme": "vs40hotburnx",
	"The Wild Machine": "vs40madwheel",
	"Pirate Gold": "vs40pirate",
	"Pirate Gold Deluxe": "vs40pirgold",
	"Rise Of Samurai III": "vs40samurai3",
	"Shining Hot 40": "vs40sh",
	"Spartan King": "vs40spartaking",
	"Street Racer": "vs40streetracer",
	"Voodoo Magic": "vs40voodoo",
	"Wild Depths": "vs40wanderw",
	"Wild West Gold": "vs40wildwest",
	"Congo Cash": "vs432congocash",
	"3 Genie Wishes": "vs50aladdin",
	"Aladdin's Treasure": "vs50amt",
	"Lucky Dragons": "vs50chinesecharms",
	"Diamond Cascade": "vs50dmdcascade",
	"Hercules Son of Zeus": "vs50hercules",
	"Kraken's Sky Bounty": "vs50jucier",
	"Juicy Fruits": "vs50juicyfr",
	"Mighty Kong": "vs50kingkong",
	"Might of Ra": "vs50mightra",
	"North Guardians": "vs50northgard",
	"Pixie Wings": "vs50pixie",
	"Safari King": "vs50safariking",
	"Hokkaido Wolf": "vs576hokkwolf",
	"Wild Wild Riches": "vs576treasures",
	"Aztec Gems": "vs5aztecgems",
	"Dewavegas Joker's Jewels": "vs5dewajoker",
	"Dragon Hot Hold & Spin": "vs5drhs",
	"Dragon Kingdom - Eyes of Fire": "vs5drmystery",
	"Fire Hot 5™": "vs5firehot",
	"Hot to Burn": "vs5hotburn",
	"Joker's Jewels": "vs5joker",
	"Little Gem": "vs5littlegem",
	"Shining Hot 5": "vs5sh",
	"Super Joker": "vs5spjoker",
	"Striking Hot 5™": "vs5strh",
	"Super 7s": "vs5super7",
	"Triple Dragons": "vs5trdragons",
	"Ultra Hold and Spin": "vs5ultra",
	"Ultra Burn": "vs5ultrab",
	"Bronco Spirit": "vs75bronco",
	"Golden Beauty": "vs75empress",
	"Aztec Bonanza": "vs7776aztec",
	"Aztec Treasure": "vs7776secrets",
	"Fire 88": "vs7fire88",
	"7 Monkeys": "vs7monkeys",
	"7 Piggies": "vs7pigs",
	"Hockey Attack": "vs88hockattack",
	"Magic Journey": "vs8magicjourn",
	"Aztec Gems Deluxe": "vs9aztecgemsdx",
	"Master Chen's Fortune": "vs9chen",
	"Hot Chilli": "vs9hotroll",
	"Monkey Madness": "vs9madmonkey",
	"Pirates Pub": "vs9outlaw",
	"Piggy Bank Bills": "vs9piggybank",
	"Aztec King Megaways": "vswaysaztecking",
	"Cash Bonanza": "vswaysbankbonz",
	"Big Bass Bonanza Megaways": "vswaysbbb",
	"Big Bass Hold & Spinner Megaways": "vswaysbbhas",
	"Book of Golden Sands™": "vswaysbook",
	"Buffalo King Megaways": "vswaysbufking",
	"Chilli Heat Megaways": "vswayschilheat",
	"vswaysconcoll": "vswaysconcoll",
	"Crystal Caverns Megaways": "vswayscryscav",
	"The Dog House Megaways": "vswaysdogs",
	"Elemental Gems Megaways": "vswayselements",
	"Diamonds of Egypt": "vswayseternity",
	"Floating Dragon Hold & Spin Megaways™": "vswaysfltdrg",
	"Frogs & Bugs": "vswaysfrbugs",
	"Spin & Score Megaways™": "vswaysfrywld",
	"Frozen Tropics": "vswaysftropics",
	"Fury of Odin Megaways™ ": "vswaysfuryodin",
	"Power of Thor Megaways": "vswayshammthor",
	"Star Bounty": "vswayshive",
	"Gold Oasis": "vswaysincwnd",
	"Tropical Tiki": "vswaysjkrdrop",
	"Lucky Lightning": "vswayslight",
	"5 Lions Megaways": "vswayslions",
	"Legend of Heroes Megaways": "vswayslofhero",
	"Lucky Fishing Megaways™": "vswaysluckyfish",
	"Madame Destiny Megaways": "vswaysmadame",
	"3 Dancing Monkeys™": "vswaysmonkey",
	"Mystery Of The Orient": "vswaysmorient",
	"Old Gold Miner Megaways": "vswaysoldminer",
	"PIZZA! PIZZA? PIZZA!™": "vswayspizza",
	"Power of Merlin Megaways": "vswayspowzeus",
	"5 Rabbits Megaways": "vswaysrabbits",
	"The Red Queen™": "vswaysredqueen",
	"Great Rhino Megaways": "vswaysrhino",
	"Rocket Blast Megaways": "vswaysrockblst",
	"Wild Celebrity Bus Megaways™": "vswaysrsm",
	"Rise of Samurai Megaways": "vswayssamurai",
	"Candy Stars™": "vswaysstrwild",
	"Cowboy Coins™": "vswaysultrcoin",
	"Curse of the Werewolf Megaways": "vswayswerewolf",
	"Mystic Chief": "vswayswest",
	"Wild West Gold Megaways": "vswayswildwest",
	"Wild Wild Bananas™": "vswayswwhex",
	"Wild Wild Riches Megaways": "vswayswwriches",
	"Extra Juicy Megaways": "vswaysxjuicy",
	"Yum Yum Powerways": "vswaysyumyum",
	"Zombie Carnival": "vswayszombcarn"
	
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
	$Slot_container36/p36,
	$Slot_container37/p37
	
]

func _load_profile_textures():
	for i in range(373):
		var path = "res://pck/assets/slot/pragmatic/" + str(i+1) + "a.png"
		var texture = load(path)
		slot_textures.append(texture)
		
	# Apply textures to slots in each container
	var key_index = 0
	for slot_container in slot_containers:
		var slots = slot_container.get_children()
		var slot_count = 0

		for a in range(key_index, min(key_index + 10, slot_textures.size())):
			var slot = slots[slot_count]
			if slot is TextureButton:
				slot.texture_normal = slot_textures[a]
				slot_count += 1

		key_index += 10
	
	var slot38 = $Slot_container38/p38.get_children()
	var count38 = 0
	for b in range(370, min(373, slot_textures.size())):
		var slot_child = slot38[count38]
		if slot_child is TextureButton:
			slot_child.texture_normal = slot_textures[b]
			count38 += 1


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
			slot_count += 1
		
		key_index += 10
		
	
	var slot38 = $Slot_container38/p38.get_children()
	var count38 = 0
	for vi in range(370, min(373, keys_array.size())):
		var slot = slot38[count38]  
		var key = keys_array[vi]
		slot.set_name(str(key))
		slot.connect("pressed", self, "_on_game_pressed", [slot])
		count38 += 1

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
	
	_load_profile_textures()
	
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
	var accesskey = PRAGMATIC_LIST[game_name]
	
	print(game_name,",",accesskey)
	
	var postman_url = "http://redboxmm.tech:8081/acrf-qarava-slot/api/slotplayconnect/getplaylink"

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
	OS.shell_open(Config.slot_url)
	
#	var message = {
#		"uniquekey": Config.UNIQUE,
#		"username": Config.config.user.username,
#		"sessionFor": "SECOND",
#		"stateForFirst": "",
#		"stateForSecond": "STATE_PLAY",
#		"message": Config.slot_url
#	}
#	print("This is on Slot pressed Message : ", message)
#	_send(message)



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
				
	var slot38 = $Slot_container38/p38.get_children()
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
				
	var slot38 = $Slot_container38/p38.get_children()
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
			
		"37to38":
			$RightButtons/Right.hide()
			
		"1to2":
			$LeftButtons/Left.show()
			
		"38to37":
			$RightButtons/Right.show()



func _on_Cooldown_timeout():
	can_press = true
