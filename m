Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id A344867B6C
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Aug 2006 04:48:19 +1000 (EST)
In-Reply-To: <1155139501.17187.76.camel@localhost.localdomain>
References: <20060809140336.9E3C93535D4@atlas.denx.de>
	<1155139501.17187.76.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1E9164B4-0EFC-4A7D-8C1C-9D7365232E16@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: RFC: Location for Device Tree Sources?
Date: Wed, 9 Aug 2006 13:47:59 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 9, 2006, at 11:05, Benjamin Herrenschmidt wrote:

>> It's just that I think that the DT *sources* should not  be  part  of
>> the  U-Boot  soutrce  tree, and that the DT should be in fact part of
>> the kernel images that gets booted by U-Boot.
>
> Fair enough, I misunderstood.
>
>> This has been discussed before (see archives), and the agreement  (?)
>> was  to  use  U-Boot's multifile image format for this purpose, where
>> you can combine a Linux kenrel image with a DT image  into  one  file
>> bootable by U-Boot.
>
> Well, I would still like something else. For example, I'm vendor  
> NetFoo
> selling network appliances (ADSL modems, routers, wireless APs, ...).
>
> A certain amount of my products are based on a very similar chipset
> provided by vendor NarrowCom, same core, same ethernet cell, though my
> devices have subtle differences in the various varieties of those  
> chips
> used and what other chips are put around on the board.
>
> I want my devices to have a firmware that pass a DT to the kernel.  
> That
> DT is bolted into the firmware. In fact, it could be separate flash
> blocks (especially if the flash has some small blocks) from the actual
> firmware code but that does not really matter.
>
> That way, I can distribute and maintain a single kernel image update
> package as part of my software update/maintainance solution.


I think you'll find that the changes Matt McClintock made to u-boot  
make this quite possible.  The dtb is kept separate, and passed in by  
u-boot.  If those patches are acceptable, they provide what you  
want.  If they aren't acceptable, we'd be happy to make changes.  We  
just need to know, one way or another.

Andy
