Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc1-s37.bay0.hotmail.com (bay0-omc1-s37.bay0.hotmail.com
	[65.54.246.109]) by ozlabs.org (Postfix) with ESMTP id 996DD67B55
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Oct 2006 06:27:26 +1000 (EST)
Message-ID: <BAY110-F29333102EBA79FA70A2873B2140@phx.gbl>
In-Reply-To: <20061011161451.3292.qmail@web56312.mail.re3.yahoo.com>
From: "Ming Liu" <eemingliu@hotmail.com>
To: rdcorle@yahoo.com, linuxppc-embedded@ozlabs.org
Subject: RE: plb_temac, ML403, linux 2.4.26, EDK 7.1
Date: Wed, 11 Oct 2006 20:24:51 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,


>So, right now I am trying to get the plb_temac to compile and get errors 
about the defines XPAR_XTEMAC_* within the linux directories 
../drivers/net/xilinx_enet.  I see that the edk gets the defines within the 
xparameters.h file of the xapp902 project.  I also see that my 
C:\EDK\sw\ThirdParty\bsp\linux_mvl31_v1_01_a\drivers don't have anything 
for a plb_temac.

Yes. In MV3.1, there is no gige enet supported. You should include the 
patch for TEMAC by yourself.

>Q:    Is my error related to an incorrect setup of the linux or with the 
EDK?

Try to check your xparameters.h file and find if there are the definations.

>Q:    t is stated that the plb_temac drivers are in EDK 8.1.  Can I stick
>with 7.1 or must I ugprade?

I don't think that's the problem of 7.1, if you can make sure you use a 
correct core for TEMAC and generated correct BSP files.

>Q:    Where in the linux tree should I look for the xtemac
>stuff?  Is this what the EDK pushes on to the tree or is it released
>within the MVL distro?

Try to find the patch for TEMAC in this list. 

>Q    Based on posts by David and Ming, it
>appears that I must use xilinx_gige to get up to gigE speeds.  Will the
>plb_temac support this data rate and, if so, is this a transparent
>support or do I need to go the route suggested to Ming and
>overwrite files in xilinx_enet?

Temac is tri-mode including 1000M/s speed. sorry that i cannot understand 
this question very well.

Ming

_________________________________________________________________
享用世界上最大的电子邮件系统— MSN Hotmail。  http://www.hotmail.com  
