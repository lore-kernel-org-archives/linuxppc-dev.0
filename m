Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id B1B42DDE24
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Jan 2007 09:41:45 +1100 (EST)
In-Reply-To: <1168385038.3964.44.camel@saruman.qstreams.net>
References: <1168385038.3964.44.camel@saruman.qstreams.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <16C201CD-708C-4DDC-85DC-A9DA893A577D@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: Using fixed_phy with gianfar
Date: Wed, 10 Jan 2007 16:41:55 -0600
To: bwarren@qstreams.com
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jan 9, 2007, at 17:23, Ben Warren wrote:

> Hello,
>
> My custom board has a couple of Ethernet switches attached via  
> RvMII to
> the 'Gianfar' controllers of an MPC8349 CPU.  We're using SPI  
> instead of
> MDIO for control of the switches, and it looked like the 'fixed.c' PHY
> driver was the right thing to use.  BTW, I'm using a 2.6.19 kernel.


That sounds reasonable.


>
> When I 'ifconfig up' one of the interfaces, the Gianfar driver  
> tries to
> find a device on the MDIO bus of the variety bus_id:phy_id, where both
> bus_id and phy_id are numeric (defined in fsl_devices.h).  The  
> Fixed PHY
> driver creates devices on the MDIO bus with a bus_id that is a string,
> for example "fixed_1@100:1".  Obviously, these will never match  
> up.  The
> very crude hack I made to get things working was to modify the Gianfar
> driver to match the "fixed" string.


Yeah, that needs to be fixed.

*Adds to list*

Andy
