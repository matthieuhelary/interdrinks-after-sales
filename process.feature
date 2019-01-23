Feature: As an employee, I can inform the customer some products are OOS during picking
As an employee, I can inform a customer some products are out of stock
And I ask him to cancel or proceed his order

	@pwa @waiting-orders
	Scenario: As an employee, I can access waiting orders interface
		Given I am authenticated as an employee
		And I am on "waiting-orders.interdrinks.fr" page
		Then I should see a search input

	@pwa @waiting-orders
	Scenario: As a customer, I cannot access waiting orders interface	
		When I am not authenticated as an employee
		Then I shouldn't see "waiting-orders.interdrinks.fr" page

	@pwa @waiting-orders
	Scenario: As an employee, I search for an order
		Given I am on "waiting-orders.interdrinks.fr" page
		When I fill in the search input with order id "1234"
		Then I should see the list of products in the order
		And I should be on "waiting-orders.interdrinks.fr/order/1234" page

	@pwa @waiting-orders
	Scenario: As an employee, I can create waiting order
		Given I am on "waiting-orders.interdrinks.fr/order/1234" page
		And there is the following products and quantities in the order :
		|id_product |quantities	|
		|82			|1			|
		|83			|2			|
		|84			|3			|
		When I checked id_product 82
		And I checked id_product 83 and I select 1 quantity
		And I click on "Validate" button
		Then the list of products that are out of stock should be saved
		And the customer should receive an SMS

	@api @waiting-orders
	Scenario: Change order status when waiting order is created
		When a waiting order is created
		Then the order status should be changed to "order_on_hold"	

	@api @waiting-orders
	Scenario: As an employee, I can create a waiting order
		Given I am authenticated as an employee
		When I do a POST request on "/api/order_waiting"
		And I fill in the body with :
		"""
		{
			"id_order" : 1234,
			"id_product" : 82,
			"quantity":2
			"status_id" : 1
			"handled" : 0
		}

		OR (to be checked with Clément)

		{
	
			"id_order" : 1234,
			"missing_product" : [
				{
					"id_product" : 82,
					"quantity":2
				},{
					"id_product" : 82,
					"quantity":2
				}],
			"status_id" : 1,
			"handled" : 0

		}	
		"""
		Then a waiting order is create

		Description : 

		Create the following tables
		order_waiting
		order_waiting_products
		order_waiting_status


	@api	
	Scenario: As customer, I cannot create a waiting order


	@api	
	Scenario: As employee, I can update a waiting order
	PUT "api/order_waiting/1"

	@api	
	Scenario: As a customer, I can update a portion of a waiting order
	Uniquement le status

	@api	
	Scenario: If waiting order status change to 2
		When a waiting order status change to 2
		Then the order status should be changed to "cancelled"

	@api	
	Scenario: If waiting order status change to 3
		When a waiting order status change to 3
		Then the order status should be changed to "picking_in_progress"

	@api
	Scenario: As employee, I can access to the list of waiting order with a filter by status
		Given I am authenticated as an employee
		When I do a GET request on "api/order_waiting?status_id=1"
		Then I should see the list of orders with the status "Request Sent"
		And the list should be ordered by created_at desc 

	@pwa 
	Scenario: As employee, I can view a list of orders with waiting order status in "Request Sent"	

	@api
	Scenario: As employee, I can access to the list of waiting order with a filter by status
		Given I am authenticated as an employee
		When I do a GET request on "api/order_waiting?status_id=2"
		Then I should see the list of orders with the status "Order Cancelled"
		And the list should be ordered by updated_at asc

	@pwa 
	Scenario: As employee, I can view a list of orders with waiting order status in "Order Cancelled"		

	@api	
	Scenario: As employee, I can access to the list of waiting order with a filter by status
		Given I am authenticated as an employee
		When I do a GET request on "api/order_waiting?status_id=3"
		Then I should see the list of orders with the status "Continue Order"
		And the list should be ordered by updated_at asc

	@pwa 
	Scenario: As employee, I can view a list of orders with waiting order status in "Continue Order"		
	


	@api
	Scenario: Check stock when the order is cancelled


	@api
	Scenario: Authentification through barcode ?
	See with Bernhard





GET "api/order_waiting?order=1234"




	Scenario: 
	PUT "api/order/1234"
	Pour changer le status de la commande sur "Order on hold"


	@api
	Scenario: Peut pas mettre créer des commandes en attente pour les renvois etc 
	Si commande marketplace, on envoie pas de SMS

	@api
	Scenario: Envoyer un email pour les commandes marketplace 


	@pwa
	Scenario Outline: As employee, I can handle a waiting order
		Given I am on "" page
		When I checked / swipe 
		Then the order waiting order is handled
		And it should be removed from the list

		Examples: 



-----------------------------------------------------------------------------------------------------------------------------------------

Feature: As a customer, I can define take actions if my order is on hold

	@pwa
	Scenario: Receiving an SMS
		Given I placed an order 1234
		When an employee create a waiting order
		Then I should receive a SMS
		And the link should be :
		# to be filled
		And I clicked on the link
		Then I should be on "" page

	@pwa
	Scenario: Authentification
		Given I am 

	@pwa
	Scenario: Missing products and broken
		Given I am "" page
		When I click on "" link
		And I click on "" option
		And I checked ""
		And I checked ""
		And I select 1 quantity 
		Then 

	@pwa
	Scenario: Display refund method
		Given I am on ""page
		Then I should see the refund method that are offered to me

		>>> API

	@api	
	Scenario: As a customer, I can get the order refund amount I am eligible
		Given I am authenticated as a customer
		When I do a GET request on "/api/order_refund_amount?order=1234"
		Then I should receive a response similar to :
		"""
		{
			"wallet" : 10
			montant : 10
			addition : 2
			paypal :10
			adyen	: 10

		}	
		"""

	@api	
	Scenario: As a customer, I can't ask a refund 

	Scenario: Display refund amount

	Scenario: Select refund method

	Scenario: Refund a customer



-----------------------------------------------------------------------------------------------------------------------------------------

Feature: As a customer I can access my after sales interface


	@api
	Scenario: As customer, I can access the after sales interface menu
		Given I am not authenticated
		When I do a GET request on "/api/xxxxx"
		Then I see a menu	

	@pwa
	Scenario: Menu
		When I am "" page
		Then I see

	--> Dresser la liste des actions possibles en fonction du status de la commande	
	--> Si les 2 colis sont pas arrivés ?

	@pwa
	Scenario: FAQ

	Scenario: As a customer, I can do this action if I am authenticated

	Scenario: As customer, I can do this action if I am not authenticated


	Scenario: As customer, I can define missing products

	Scenario: As customer, I can define broken products

	@api
	Scenario: As customer, I can get the list of products refundable
		When I placed an order
		And there is the following products and quantities in the order :
		|id_product |quantities	|
		|82			|1			|
		|83			|2			|
		|84			|3			|
		And there is a waiting order with the following products and quantities :
		|id_product |quantities	|
		|82			|1			|
		|83			|1			|
		Then I see a list of products refundable
		And the list should be the following products and quantities :
		|id_product |quantities	|
		|83			|1			|
		|84			|2			|
		And I cannot be refunded of the following products and quantities :
		|id_product |quantities	|
		|82			|1			|
		|83			|1			|


Scenario: Customer receive an SMS
> Addresse de facturation vérifier le numéro


Scenario: Construction du lien


Scenario: Connexion

Scenario: Changer le status du order_waiting pour 2

Scenario: Changer le status du order_waiting pour 3




Scenario: Calculate amount to refund !!! (compliqué)
Lot of rules by Juliette

Scenario: POST "api/order_refund"
Pour enregistrer le refund


Scenario: 



Scenario: 
Remboursement durant la préparation
Remboursement après avoir reçu la commande


Scena



Si montant du dommage > montant payé par le client
On rembourse uniquement sur wallet + 2€

Si montant du dommage < montant payé par le client
On rembourse sur les 3 moyens de paiement

Coffrets de marques ou pièces d'un produit ?


Attendre que tous les colis soient arrivés avant de pouvoir dire qu'il manque des produits.


tracking page




















Feature: List of actions

	Scenario: 
		Given 



Produit manquant ou cassé = montant des produits +  2€ (si wallet)
Si rupture de stock durant la préparation de commande : montant du produit + 3,90 € (si wallet)
Expliquer que les 3,90 € c'est pour prendre un nouveau colis avec Mondial Relay

Si expédition ou livraison retardée: Wallet sur le montant des frais de livraisons.



customer-service.feature

Follow package tracking

Modify billing address
Modify invoice address
Modify picking point

Cancel an order
Add a product to the order
Remove a product from the order
Change a product from the order


Product missing
Product broken
Wrong product

Return product
Refund 

GLS litige
Chronopost litige


810098

809969

Packaged refused
utilisation des 14 jours rétractation
Changer carrier for a resend ?
Take picture of things broken
Attestation sur l'honneur


en attente


/api/refund

{
	"order_id" : 1234
	"products" : []
	"reason"
	"message"

}


/api/resend


{





}


/api/orders/1234/waiting

{
	
	"product" :[

		"id_product" : 82
		"quantity" : 1

	]

}




1- Stocker les infos des assortiments pour la commande

2- Table remboursement produits à construire

3- Table remboursement frais de livraisons


Endpoint qui liste les actions possibles en fonction de l'état de la commande ?




