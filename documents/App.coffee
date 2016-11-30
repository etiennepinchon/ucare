mainColor = "#ec3b6b"

class MainScreen extends View

	this.statusBar = undefined

	showMainApp : ->

		that = this

		this.mainContainer = new View
			width: "100%"
			height: "100%"
			x: 0
			y: 0
			background: white
			parent: this

		# ------------------------------
		# TOP BAR
		# ------------------------------

		topBar = new View
			width: "100%"
			height: 60
			background: "white"
			y: 0
			x: 0
			borderColor: "#f0f0f0"
			borderBottomWidth: 1
			index: 100
			parent: this.mainContainer

		menuIcon = new Button
			width: 42
			height: 42
			backgroundColor: clear
			image: '/documents/images/menuIcon.svg'
			imageSize: .4
			imagePosition: center
			x: 0
			bottom: -2
			padding: 0
			paddingTop: 20
			click: -> menu.open()
			parent: topBar

		logoText = new Image
			width: 155/1.9
			height: 59/1.9
			image: '/documents/images/logoText.svg'
			x: (this.mainContainer.cwidth() - (155/1.9))/2
			bottom: 3
			parent: topBar

		# ------------------------------
		# MAPS
		# ------------------------------

		map = new View
			width: 4318/2
			height: 2682/2
			image: '/documents/images/maps.jpg'
			imageSize: 1.1
			x: -1030
			y: -560
			parent: this.mainContainer

		map.draggable.enable = yes

		###
		shouldAnimatePin = yes
		map.draggable.onDrag ->
			shouldAnimatePin = no
		###

		map.draggable.constraints =
			x: -4318/4
			y: -2682/4
			width: (4318/2)*1.5
			height: (2682/2)*1.5

		# Pin
		pinIcon1 = new View
			width: 16
			height: 16
			backgroundColor: clear
			image: '/documents/images/pinIcon.svg'
			x: 1030
			y: 560
			parent: map

		
		pinIcon1.data =
			name: "Jade Pharmacy"
			distance: "3.4 miles"

		pinIcon1.onClick ->
			searchBar.input.value = this.data.name
			bottomBar.title.text = this.data.name
			bottomBar.summary.text = this.data.distance + " • Close Now"
			bottomBar.summary.assign 'Close Now',
				color: '#ed3131'
				fontWeight: 600
			map.animate 
				props:
					x: -880
					y: -350
				curve: 'spring(400, 20, 10)'
			this.animate
				props: scale: 1.5
				curve: 'spring(400, 20, 10)'
			pinIcon2.animate
				props: scale: 1
				curve: 'spring(400, 20, 10)'
			pinIcon.animate
				props: scale: 1
				curve: 'spring(400, 20, 10)'

		pinIcon = new View
			width: 16
			height: 16
			backgroundColor: clear
			image: '/documents/images/pinIcon.svg'
			x: 1190
			y: 760
			scale: 1.5
			parent: map

		pinIcon.data =
			name: "CVS Pharmacy"
			distance: "1.2 miles"

		pinIcon.onClick ->
			searchBar.input.value = this.data.name
			bottomBar.title.text = this.data.name
			bottomBar.summary.text = this.data.distance + " • Open Now"
			bottomBar.summary.assign 'Open Now',
				color: '#2acc18'
				fontWeight: 600
			map.animate 
				props:
					x: -1030
					y: -560
				curve: 'spring(400, 20, 10)'
			this.animate
				props: scale: 1.5
				curve: 'spring(400, 20, 10)'
			pinIcon2.animate
				props: scale: 1
				curve: 'spring(400, 20, 10)'
			pinIcon1.animate
				props: scale: 1
				curve: 'spring(400, 20, 10)'
		###
		pinIcon.zoomOut = ->
			return if shouldAnimatePin is false
			that = this
			this.animate
				props:
					scale: 1
				duration: 0.7
				then: ->
					that.zoomIn()

		pinIcon.zoomIn = ->
			return if shouldAnimatePin is false
			that = this
			this.animate
				props:
					scale: 1.3
				duration: 0.7
				then: ->
					that.zoomOut()
		pinIcon.zoomIn()
		
		Interval 2, ->
			shouldAnimatePin = yes
			pinIcon.zoomIn()
		###

		pinIcon2 = new View
			width: 16
			height: 16
			backgroundColor: clear
			image: '/documents/images/pinIcon.svg'
			x: 1290
			y: 860
			parent: map

		pinIcon2.data =
			name: "Newark Haller's Pharmacy"
			distance: "2.3 miles"

		pinIcon2.onClick ->
			searchBar.input.value = this.data.name
			bottomBar.title.text = this.data.name
			bottomBar.summary.text = this.data.distance + " • Open Now"
			bottomBar.summary.assign 'Open Now',
				color: '#2acc18'
				fontWeight: 600
			map.animate 
				props:
					x: -1120
					y: -620
				curve: 'spring(400, 20, 10)'
			this.animate
				props: scale: 1.5
				curve: 'spring(400, 20, 10)'
			pinIcon.animate
				props: scale: 1
				curve: 'spring(400, 20, 10)'
			pinIcon1.animate
				props: scale: 1
				curve: 'spring(400, 20, 10)'

		# ------------------------------
		# SEARCH INPUT
		# ------------------------------

		searchBar = new View
			width: "100%"
			y: 70
			backgroundColor: clear
			height: 28+15
			parent: this.mainContainer
		inputs = 
			width: '90%'
			height: 28
			fontSize: 11
			fontWeight: 500
			align: left
			spacing: .7
			backgroundColor: white
			borderColor: "#ddd"
			borderWidth: 1
			x: 15
			paddingLeft: 30
			paddingY: 20
			borderRadius: 3

		searchBar.input = new TextInput
			props: inputs
			placeholder: "Search"
			value: "CVS Pharmacy"
			parent: searchBar

		searchBar.searchIcon = new View
			width: 16
			height: 16
			backgroundColor: clear
			image: '/documents/images/searchIcon.svg'
			imageSize: .9
			imagePosition: center
			x: 15+10
			y: 13
			opacity: .7
			parent: searchBar

		# ------------------------------
		# BOTTOM
		# ------------------------------

		bottomBar = new View
			width: "100%"
			height: 493
			background: "rgba(255, 255, 255, .98)"
			bottom: -368
			x: 0
			borderColor: "#f0f0f0"
			borderTopWidth: 1
			index: 100
			borderRadius: 12
			parent: this.mainContainer

		bottomBar.open = ->
			this.animate
				props:
					bottom: -180
				curve: 'spring(400, 20, 5)'
		bottomBar.close = ->
			this.animate
				props:
					bottom: -368
					borderRadius: 12
				curve: 'spring(400, 20, 5)'
				bottomBar.handle.fadeIn()

		bottomBar.onSwipeUp ->
			if bottomBar.bottom > -190
				this.animate
					props:
						bottom: -20
						borderRadius: 0
					curve: 'spring(400, 20, 5)'
				bottomBar.handle.fadeOut()

			else if bottomBar.bottom > -378
				bottomBar.open()
			

		bottomBar.onSwipeDown bottomBar.close

		bottomBar.onClick ->
			if bottomBar.bottom > -250
				bottomBar.close()
			else
				bottomBar.open()
		

		bottomBar.handle = new View
			width: 40
			height: 4
			x: (this.mainContainer.cwidth()-40)/2
			y: 5
			backgroundColor: '#EEE'
			borderRadius: 12
			parent: bottomBar

		bottomBar.title = new Text
			height: 28
			x: 16
			y: 16
			fontSize: 16
			fontWeight: 700
			spacing: .4
			text: "CVS Pharmacy"
			backgroundColor: clear
			color: black
			#opacity: .75
			parent: bottomBar

		bottomBar.summary = new Text
			height: 28
			x: 16
			y: 16+24
			fontSize: 13
			fontWeight: 500
			spacing: .2
			text: "1.2 miles • Open Now"
			backgroundColor: clear
			color: black
			parent: bottomBar
		
		bottomBar.summary.assign 'Open Now',
			color: '#2acc18'
			fontWeight: 600

		bottomBar.setPickUp = new Button
			width: '90%'
			height: 42
			y: 70
			fontSize: 12
			fontWeight: 500
			align: center
			spacing: .4
			text: "Set pickup location"
			x: 14
			backgroundColor: mainColor
			borderRadius: 3
			parent: bottomBar
		bottomBar.setPickUp.uppercase()
		bottomBar.setPickUp.onClick (e)->
			e.stopPropagation()
			bottomBar.close()
			that.mainContainer.fadeOut
				duration: .2
				curve: 'easeout'
				#props:
				#	scale: 0.95
				then:->
					Hide that.statusBar
					that.showCamera()

		bottomBar.separator = new View
			width: "100%"
			height: 1
			backgroundColor: '#f0f0f0'
			y: 70 + bottomBar.setPickUp.height + 20
			parent: bottomBar

		bottomBar.ratings = new View
			width: 100
			height: 18
			backgroundColor: clear
			image: '/documents/images/ratings.svg'
			x: 14
			y: 70 + bottomBar.setPickUp.height + 36
			parent: bottomBar

		bottomBar.ratingsNb = new Text
			height: 28
			right: 16
			y: 70 + bottomBar.setPickUp.height + 41
			fontSize: 12
			fontWeight: 600
			spacing: .2
			text: "42 Reviews"
			backgroundColor: clear
			align: right
			color: black
			opacity: .25
			parent: bottomBar


		# ------------------------------
		# MENU LIST
		# ------------------------------

		bottomBar.commentsData = [
			name: 'Jeff	Santiago'
			comment: 'Served very fast! Thank you.'
		,
			name: 'Timothy	Shaw'
			comment: 'Polite and helpful, go to CVS Pharmacy next time your are sick!'
		,
			name: 'Eduardo	Hansen'
			comment: 'Great support, fast, trustworthy.'
		,
			name: 'Alvin Leonard'
			comment: 'First!'
		]

		bottomBar.commentsList = new List
		   x: 14
		   y: 70 + bottomBar.setPickUp.height + 41 + 30
		   length: bottomBar.commentsData.length
		   parent: bottomBar

		bottomBar.commentsList.each (item, index) ->

			if not item
				item = new ListItem

				item.name = new Text
					text: bottomBar.commentsData[index].name
					padding: 4
					#paddingY: 16
					align: left
					color: mainColor
					fontSize: 12
					fontWeight: 500
					backgroundColor: clear
					lineHeight: 20
					parent: item

				item.comment = new Text
					text: bottomBar.commentsData[index].comment
					padding: 4
					paddingY: 5
					align: left
					color: '#333'
					fontSize: 12
					fontWeight: 300
					backgroundColor: clear
					lineHeight: 20
					parent: item

			return item




		# ------------------------------
		# MENU
		# ------------------------------

		menuOverlay = new View
			width: "100%"
			height: "100%"
			x: 0
			y: 0
			index: 300
			backgroundColor: rgba(0, 0, 0, 0.85)
			click: -> menu.close()
			display: no
			opacity: 0
			parent: this.mainContainer

		menu = new View
			width: "100%"
			height: "100%"
			x: -that.cwidth() - 20
			y: 0
			index: 300
			backgroundColor: white
			opacity: 0
			parent: this.mainContainer

		menu.open = ->
			this.fadeIn
				props:
					x: -60
				curve: 'spring(400, 20, 5)'
			Show menuOverlay
			menuOverlay.fadeIn .2

		menu.close = ->
			this.fadeOut
				props:
					x: -that.cwidth() - 20
				curve: 'spring(400, 10, 0)'
			menuOverlay.fadeOut
				duration: .2
				then: ->
					Hide menuOverlay

		menu.content = new View
			width: "80%"
			height: "100%"
			right: 0
			y: 0
			backgroundColor: clear
			parent: menu

		menu.content.onSwipeLeft ->
			menu.close()

		menu.profilePictureBorder = new View
			width: "100%"
			height: 1
			x: 0
			y: 180
			backgroundColor: '#F0F0F0'
			parent: menu.content

		menu.profilePicture = new View
			width: 80
			height: 80
			borderRadius: 50
			image: "https://pbs.twimg.com/profile_images/667881247654457344/6YCsVANr.jpg"
			x: 20
			y: 45
			parent: menu.content


		menu.profileName = new Text
			width: '100%'
			height: 28
			x: 20
			y: 45 + 80 + 18
			fontSize: 16
			fontWeight: 600
			spacing: .7
			text: "Etienne Pinchon"
			backgroundColor: clear
			opacity: .75
			parent: menu.content

		

		###
		menu.profilePicture.gradient = new View
			width: "100%"
			height: 100
			x: 0
			bottom: 0
			backgroundColor: Color.gradient('rgba(0, 0, 0, 0)', 'rgba(0, 0, 0, 1)')
			parent: menu.profilePicture
		###

		# ------------------------------
		# MENU LIST
		# ------------------------------

		menuOptions = [
		   text: 'Your Orders'
		,
		   text: 'Free Orders'
		,
		   text: 'Help'
		,
		   text: 'Settings'
		]

		myList = new List
		   x: 20
		   y: 190
		   length: menuOptions.length
		   parent: menu.content

		myList.each (item, index) ->

			if not item
				item = new ListItem

				myLink = new Button
					text: menuOptions[index].text
					padding: 4
					paddingY: 16
					align: left
					color: '#333'
					fontSize: 16
					fontWeight: 300
					backgroundColor: clear
					hoverAnimated: color: mainColor
					click: ->
						if this.parent.itemIndex() is 0
							menu.close()
							that.mainContainer.fadeOut(.2)
							that.showOrders()

					parent: item
			myLink.menu_index = index

			return item

		menu.legal = new Button
			bottom: 5
			fontSize: 12
			fontWeight: 400
			align: center
			spacing: .7
			text: "Legal"
			color: '#333'
			backgroundColor: clear
			#color: mainColor
			hoverAnimated: color: mainColor
			parent: menu.content

		menu.version = new Text
			bottom: 14
			right: 18
			fontSize: 12
			fontWeight: 400
			align: right
			spacing: .7
			text: "v0.1.0"
			color: '#333'
			backgroundColor: clear
			#color: mainColor
			width: 100
			opacity: .6
			parent: menu.content

	showOrders : ->
		
		that = this

		this.statusBar.white()

		this.orderContainer = new View
			width: "100%"
			height: "100%"
			x: 0
			y: 0
			background: '#f5f5f5'
			index: 200
			y: this.cwidth()+50
			opacity: 0
			parent: this

		# ------------------------------
		# TOP
		# ------------------------------

		topBar = new View
			width: "100%"
			height: 90
			background: mainColor
			y: 0
			x: 0
			borderColor: "#333"
			borderBottomWidth: 1
			parent: this.orderContainer

		closeIcon = new Button
			width: 42
			height: 42
			backgroundColor: clear
			image: '/documents/images/closeIcon.svg'
			imageSize: .4
			imagePosition: center
			x: 0
			top: 14
			padding: 0
			paddingTop: 20
			parent: topBar
		closeIcon.onClick ->
			that.mainContainer.opacity = 1
			that.statusBar.black()
			that.orderContainer.fadeOut
				duration: .15
				props:
					y: that.orderContainer.cheight() + 50
				curve: 'easeout'
			Delay 0.3, ->
				that.orderContainer.parent = NULL

		topBar.title = new Text
			width: '100%'
			height: 28
			bottom: 4
			fontSize: 18
			fontWeight: 300
			align: left
			spacing: .7
			text: "Orders"
			backgroundColor: clear
			color: white
			x: 14
			parent: topBar
		topBar.title.uppercase()

		# ------------------------------
		# MENU LIST
		# ------------------------------

		menuOptions = [
		   text: 'CVS Pharmacy'
		   state: 'Pending'
		,
		   text: 'Rite Aid'
		   state: '$12.89'
		,
		   text: 'CVS Pharmacy'
		   state: '$32.95'
		,
		   text: 'Walgreens Pharmacy'
		   state: '$8.72'
		]

		myList = new List
		   x: 0
		   y: 90
		   width: '100%'
		   height: this.cheight()-90
		   scrollVertical: yes
		   length: menuOptions.length
		   parent: this.orderContainer

		myList.each (item, index) ->

			if not item
				item = new ListItem
					width: '100%'
				item.container = new View
					width: '100%'
					padding: 14
					paddingY: 16
					align: left
					color: '#333'
					fontSize: 16
					fontWeight: 300
					backgroundColor: white

					marginBottom: 8
					parent: item

				item.title = new Text
					color: mainColor
					text: menuOptions[index].text
					parent: item.container

				item.state = new Text
					y: 16
					right: 45
					align: right
					width: 100
					padding: 0
					text: menuOptions[index].state
					parent: item.container

				if menuOptions[index].state is 'Pending'
					item.state.assign 'Pending',
						color: '#ed8231'

				item.imageView = new View
					width: '100%'
					height: 185
					bottom: 8
					x: 0
					image:  '/documents/images/order.jpg'
					imagePosition: center
					parent: item
			return item

		that.orderContainer.fadeIn
			props:
				y: 0
			curve: 'spring(400, 20, 5)'


	showSignUpDone : ->

		that = this

		this.signUpDoneView = new View
			width: '100%'
			height: '100%'
			y: 0
			background: white
			opacity: 0
			index: 200
			x: this.cwidth()-100
			parent: this

		# ------------------------------
		# TOP
		# ------------------------------

		topBar = new View
			width: "100%"
			height: 60
			background: "white"
			y: 0
			x: 0
			borderColor: "#f0f0f0"
			borderBottomWidth: 1
			parent: this.signUpDoneView

		topBar.title = new Text
			width: '100%'
			height: 28
			bottom: 0
			fontSize: 13
			fontWeight: 400
			align: center
			spacing: .7
			text: "About you"
			backgroundColor: clear
			#color: mainColor
			opacity: .75
			parent: topBar
		topBar.title.uppercase()

		checkIcon = new Button
			width: 42
			height: 42
			backgroundColor: clear
			image: '/documents/images/checkIcon.svg'
			imageSize: .55
			imagePosition: center
			right: 0
			bottom: 0
			padding: 0
			paddingTop: 20
			index: 20
			opacity: .9
			parent: topBar

		checkIcon.onClick ->
			#that.mainContainer.opacity = 1
			that.showMainApp()
			that.signUpDoneView.fadeOut
				duration: .15
				props:
					y: that.signUpDoneView.cheight() + 50
				curve: 'easeout'
			Delay 0.3, ->
				that.signUpDoneView.parent = NULL

			###
			that.signUpView.fadeOut
				props:
					scale: 0.9
					curve: 'spring(400, 20, 10)'
				then: ->
					Hide that.signUpView
					that.signUpView.parent = undefined
					Show that.homeContainer
					that.homeContainer.fadeIn
						props:
							scale: 1.0
							curve: 'spring(400, 20, 10)'
			###

		# ------------------------------
		# INPUT
		# ------------------------------

		inputs = 
			width: '85%'
			height: 64
			fontSize: 11
			fontWeight: 600
			align: left
			spacing: .7
			backgroundColor: clear
			borderColor: "#ddd"
			borderWidth: 0
			borderBottomWidth: 1
			opacity: .75
			x: 20
			paddingX: 10
			paddingBottom: 15

		topBar.input = new TextInput
			props: inputs
			y: 90
			placeholder: "About your medical antecedents"
			multiline: yes
			resize: no
			autoresize: yes
			parent: this.signUpDoneView
		topBar.input.uppercase()
	
		topBar.input.focus()

		that.signUpDoneView.fadeIn
			props:
				x: 0
			curve: 'spring(400, 20, 5)'


	showSignUp : ->

		that = this

		this.signUpView = new View
			width: '100%'
			height: '100%'
			y: 0
			background: white
			opacity: 0
			index: 50
			scale: 0.9
			parent: this

		# ------------------------------
		# TOP
		# ------------------------------

		topBar = new View
			width: "100%"
			height: 60
			background: "white"
			y: 0
			x: 0
			borderColor: "#f0f0f0"
			borderBottomWidth: 1
			parent: this.signUpView

		backIcon = new Button
			width: 42
			height: 42
			backgroundColor: clear
			image: '/documents/images/backIcon.svg'
			imageSize: .55
			imagePosition: center
			x: 0
			bottom: 0
			padding: 0
			paddingTop: 20
			index: 20
			opacity: .9
			parent: topBar

		backIcon.onClick ->
			that.signUpView.fadeOut
				props:
					scale: 0.9
					curve: 'spring(400, 20, 10)'
				then: ->
					Hide that.signUpView
					that.signUpView.parent = undefined
					Show that.homeContainer
					that.homeContainer.fadeIn
						props:
							scale: 1.0
							curve: 'spring(400, 20, 10)'

		topBar.title = new Text
			width: '100%'
			height: 28
			bottom: 0
			fontSize: 13
			fontWeight: 400
			align: center
			spacing: .7
			text: "Sign Up"
			backgroundColor: clear
			#color: mainColor
			opacity: .75
			parent: topBar
		topBar.title.uppercase()

		# ------------------------------
		# INPUTS
		# ------------------------------

		inputs = 
			width: '85%'
			height: 28
			fontSize: 11
			fontWeight: 600
			align: left
			spacing: .7
			backgroundColor: clear
			borderColor: "#ddd"
			borderWidth: 0
			borderBottomWidth: 1
			opacity: .75
			x: 20
			paddingX: 10
			paddingBottom: 15

		topBar.input = new TextInput
			props: inputs
			y: 90
			placeholder: "Full name"
			parent: this.signUpView
		topBar.input.uppercase()

		topBar.input2 = new TextInput
			props: inputs
			y: 90 + 28 + 30
			placeholder: "Email"
			parent: this.signUpView
		topBar.input2.uppercase()

		topBar.input3 = new TextInput
			props: inputs
			y: 90 + (28 + 30)*2
			placeholder: "Username"
			parent: this.signUpView
		topBar.input3.uppercase()

		topBar.input3 = new TextInput
			props: inputs
			y: 90 + (28 + 30)*3
			placeholder: "Password"
			parent: this.signUpView
		topBar.input3.uppercase()

		# ------------------------------
		# BOTTOM
		# ------------------------------

		signUp = new Button
			width: '90%'
			height: 42
			bottom: 12+55
			fontSize: 12
			fontWeight: 500
			align: center
			spacing: .4
			text: "Sign up"
			x: 14
			backgroundColor: mainColor
			borderRadius: 3
			parent: this.signUpView
		signUp.uppercase()
		signUp.onClick ->
			that.signUpView.fadeOut
				duration: .2
				then: ->
					that.signUpView.parent = undefined
			that.showSignUpDone()
			#if topBar.input.value isnt '' and topBar.input.value isnt '' and topBar.input.value isnt '' and topBar.input.value isnt ''

		signIn = new Text
			width: '100%'
			height: 32
			bottom: 12
			fontSize: 12
			fontWeight: 500
			align: center
			spacing: .4
			text: "Already have an account? Sign In"
			parent: this.signUpView

		signIn.assign 'Sign In',
			fontWeight: 700
			color: mainColor

		this.signUpView.fadeIn
			props:
				scale: 1.0
				curve: 'spring(400, 20, 10)'


	showCamera : ->
		that = this

		cameraView = new View
			width: '100%'
			height: '100%'
			y: this.cwidth()+50
			background: black
			opacity: 0
			index: 200
			parent: this

		cameraView.viewFinder = new View
			width: '100%'
			height: 450
			y: 0
			background: '#F5F5F5'
			parent: cameraView

		cameraView.texture = new View
			width: '100%'
			height: '100%'
			image: '/documents/images/texture2.jpg'
			x: 0
			y: 0
			parent: cameraView.viewFinder
		
		cameraView.order = new View
			width: 275
			height: 378
			image: '/documents/images/order.jpg'
			parent: cameraView.viewFinder
		cameraView.order.center()

		cameraView.takePictureButton = new View
			width: 64
			height: 64
			bottom: 10
			background: 'rgba(237, 92, 139, .6)'
			borderRadius: 32
			borderWidth: 3
			borderColor: mainColor
			borderBox: yes
			parent: cameraView
		cameraView.takePictureButton.centerX()

		cameraView.submit = new View
			width: 32
			height: 32
			bottom: 24
			right: 18
			image: '/documents/images/checkWhite.svg'
			imageSize: .9
			opacity: 0
			display: no
			parent: cameraView
		cameraView.submit.onClick ->
			that.showOrderComplete()
			Show that.statusBar
			cameraView.fadeOut
				props:
					y: -that.cheight() - 50
				curve: 'easeout'
				duration: .2
			Delay 0.4, ->
				cameraView.parent = NULL

		cameraView.submit.onMouseDown ->
			this.opacity = .6
		cameraView.submit.onMouseUp ->
			this.opacity = 1

		cameraView.viewFlash = new View
			width: '100%'
			height: '100%'
			y: 0
			background: white
			opacity: 0
			display: no
			parent: cameraView

		cameraView.takePictureButton.onClick ->
			cameraView.viewFlash.display = yes
			cameraView.viewFlash.fadeIn
				duration: 0.15
				then: ->
					cameraView.viewFlash.fadeOut
						duration: .125
						then: ->
							Hide cameraView.viewFlash
					Show cameraView.submit
					cameraView.submit.fadeIn(.2)

		cameraView.takePictureButton.onMouseDown ->
			this.background = 'rgba(237, 92, 139, .5)'
			cameraView.submit.fadeOut(.125)
		cameraView.takePictureButton.onMouseUp ->
			this.background = 'rgba(237, 92, 139, .6)'

		cameraView.fadeIn
			props:
				y: 0
			curve: 'spring(400, 20, 5)'


	showOrderComplete : ->
		
		that = this

		orderContainer = new View
			width: '100%'
			height: '100%'
			x: 0
			y: 0
			backgroundColor: white
			index: 150
			parent: this

		background = new View
			width: "100%"
			height: "100%"
			image: '/documents/images/background.jpeg'
			imagePosition:
			   x: -800
			x: 0
			y: 0
			opacity: .1
			blur: 8
			parent: orderContainer

		# ------------------------------
		# TOP
		# ------------------------------

		topBar = new View
			width: "100%"
			height: 60
			background: "white"
			y: 0
			x: 0
			borderColor: "#f0f0f0"
			borderBottomWidth: 1
			parent: orderContainer

		topBar.title = new Text
			width: '100%'
			height: 28
			bottom: 0
			fontSize: 13
			fontWeight: 400
			align: center
			spacing: .7
			text: "Order placed"
			backgroundColor: clear
			#color: mainColor
			opacity: .75
			parent: topBar
		topBar.title.uppercase()

		# ------------------------------
		# BODY
		# ------------------------------

		completeIcon = new View
			width: 110
			height: 110
			image: '/documents/images/completeIcon.svg'
			y: 120
			x: (orderContainer.cwidth()-110)/2
			index: 100
			parent: orderContainer

		completeTitle = new Text
			width: '100%'
			height: 32
			y: 120 + 140
			fontSize: 18
			fontWeight: 300
			align: center
			spacing: .4
			text: "Time to relax"
			parent: orderContainer
		completeTitle.uppercase()

		completeText = new Text
			width: '85%'
			height: 32
			y: 120 + 140 + 32

			fontSize: 14
			fontWeight: 400
			align: center
			spacing: .4
			lineHeight: 26
			html: "You order has been placed and will soon be prepared by the pharmacy.<br>We let you know when it is ready!"
			parent: orderContainer

		completeText.x = (orderContainer.cwidth()-completeText.cwidth())/2

		# ------------------------------
		# DONE BUTTON
		# ------------------------------

		doneButton = new Button
			width: '90%'
			height: 42
			bottom: 12+12
			fontSize: 12
			fontWeight: 500
			align: center
			spacing: .4
			text: "Done"
			x: 14
			backgroundColor: mainColor
			borderRadius: 3
			parent: orderContainer
		doneButton.uppercase()
		doneButton.onClick ->
			that.mainContainer.opacity = 1
			orderContainer.fadeOut
				duration: .15
				props:
					y: orderContainer.cheight() + 50
				curve: 'easeout'
			Delay 0.3, ->
				orderContainer.parent = NULL
				
	showHome : ->
		that = this

		this.homeContainer = new View
			width: '100%'
			height: '100%'
			x: 0
			y: 0
			backgroundColor: white
			index: 150
			parent: this

		background = new View
			width: "100%"
			height: "100%"
			image: '/documents/images/background.jpeg'
			imagePosition:
			   x: -800
			x: 0
			y: 0
			opacity: .1
			blur: 8
			parent: this.homeContainer
		
		logo = new Image
			width: 100
			height: 100
			image: '/documents/images/icon.svg'
			x: (this.homeContainer.cwidth() - 100)/2
			y: 120
			parent: this.homeContainer

		logoText = new Image
			width: 155/.9
			height: 59/.9
			image: '/documents/images/logoText.svg'
			x: (this.homeContainer.cwidth() - (155/.9))/2
			y: 120 + 100
			parent: this.homeContainer

		slogan = new Text
			width: '100%'
			height: 32
			y: logoText.y + logoText.height + 5
			fontSize: 15
			fontWeight: 500
			align: center
			spacing: .8
			text: "Health lift"
			opacity: .75
			parent: this.homeContainer

		signUp = new Button
			width: '90%'
			height: 42
			bottom: 12+55
			fontSize: 12
			fontWeight: 500
			align: center
			spacing: .4
			text: "Create account"
			x: 14
			backgroundColor: mainColor
			borderRadius: 3
			borderColor: clear
			borderBottomWidth: 1
			parent: this.homeContainer
		signUp.uppercase()
		
		signUp.onClick ->
			that.homeContainer.fadeOut
				props:
					scale: 1.2
					curve: 'spring(400, 20, 10)'
				then: ->
					Hide that.homeContainer
			Delay .2, ->
				that.showSignUp()

		signIn = new Text
			width: '100%'
			height: 32
			bottom: 12
			fontSize: 12
			fontWeight: 500
			align: center
			spacing: .4
			text: "Already have an account? Sign In"
			parent: this.homeContainer

		signIn.assign 'Sign In',
			fontWeight: 700
			color: mainColor

	didAppear : ->

		this.backgroundColor = black

		this.statusBar = new View
			width: "100%"
			height: 16
			backgroundColor: clear
			image: '/documents/images/statusBar.png'
			x: 0
			y: 0
			index: 400
			parent: this

		this.statusBar.white = ->
			this.image = '/documents/images/statusBarWhite.png'

		this.statusBar.black = ->
			this.image = '/documents/images/statusBar.png'

		#this.showSignUp()
		this.showHome()
		#this.showOrderComplete()
		#this.showOrders()
		#this.showMainApp()
		return



		

# Import font
Font 'Open Sans', '700,600,500,400,300'

# Create page
App.page = new Page
	backgroundColor: white

# ------------------------------
# Cursor
# ------------------------------

Defaults.set 'View',
	backgroundColor: ''

customCursor = ->
	c =  'url(/documents/images/cursor.png) 32 32, auto'
	if Utils.isWebKit()
		c = '-webkit-image-set(url(/documents/images/cursor.png) 1x, url(/documents/images/cursor@2x.png) 2x) 32 32, auto'
	App.page.cursor = c
	
customCursor()

App.page.onMouseDown ->
	c = 'url(/documents/images/cursorActive.png) 32 32, auto'
	if Utils.isWebKit()
		c = '-webkit-image-set(url(/documents/images/cursorActive.png) 1x, url(/documents/images/cursorActive@2x.png) 2x) 32 32, auto'
	App.page.cursor = c

App.page.onMouseUp ->
	customCursor()

# ------------------------------


overlay = new View
	width: '100%'
	height: '100%'
	background: Color.gradient("#f7739e", mainColor, 90)
	opacity: .2
	x: 0
	y: 0
	parent: App.page

iphone = new View
	width: 1460/4.1
	height: 2900/4.1
	backgroundColor: clear
	image: '/documents/images/iphone.png'
	
iphone.center()

screen = new View
	width: 750/2.5
	height: 1334/2.5
	backgroundColor: white
	
screen.center()

first = new MainScreen
	width: '100%'
	height: '100%'
	parent: screen