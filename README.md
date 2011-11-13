FCat Framework for IOS
=====================

Introduction
------------
FCat is a simple Objective-C framework designed to ease development of
IOS applications.
It provides the following features:

*  Easy configuration with xml
*  View creation and lifecycle management
*  Easy navigation management
*  Easy tab management
*  Simple to use generic views


Add it to your project
----------------------
Adding FCat to your project is very straight forward, indeed you just have
to download the archive, extract it and drop it to your XCode project.

XML configuration file
----------------------
The setup of the application is taking place in an XML file, pretty much like a J2EE application.
Here is a simple example:


	<cat-application>
    
		<title>CMA</title>
    
		<group name="default">
        
			<view class="Accueil" name="accueil" preload="yes">
            	 <route action="creer" destination="Creer" />
        	</view>
    
			<view class="Creer" name="creer" title="Creer !"/>
        
    	</group>
        
	</cat-application>

