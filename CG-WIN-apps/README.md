-----Edit This------


CG-WIN-apps Cookbook
==============================
This cookbook installs and configures a system for Admin-E server application on Windows systems.

For **Windows** systems, the following actions are performed:  
1. Downloads Office 2010 and Snagit 11 installation pacakge components (MSI, **MS-Office_Setup_Config-AdminE.xml.xml**, & **Office2010_Excel_Word.msp**) from the pkgdist artifact server.  
2. Installs Word and Excel 2010 per the **Office2010_Excel_Word.msp** administration file and the using the setting the configuration per the **MS-Office_Setup_Config-AdminE.xml** file.
3. Installs Snagit vie the **MSI** file with system switches  
3. Ensures the associated applications have been instaed by a **.reg** file check.


Exceptions
------------
No exceptions defined or explicitly handled.


Requirements
------------

**Platforms:**  
This cookbook will only process platforms:  **windows\ADMIN-E**

**Cookbooks:**  
This cookbook has no direct cookbook dependencies.

**Artifact Server:**  
This cookbook is dependent upon availability of the pkgdist artifact server.


Attributes
----------
No attributes defined in this cookbook are intended to be used externally or overriden at the
environment level.


Usage
-----
#### CG-WIN-apps::default



License and Author
------------------

Author(s):: ARXC (<ARXC@capgroup.com>)
Copyright:: 2014, Capital Group
License:: All rights reserved
