Message-Id: <5.1.0.14.2.20030719101725.0215d408@falcon.si.com>
Date: Sat, 19 Jul 2003 10:19:30 -0400
To: deepesh@india.tejasnetworks.com, deepesh@india.tejasnetworks.com
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Subject: Re: Question regarding UBOOT.
Cc: Ethan Benson <erbenson@alaska.net>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.21.0307191918350.12735-100000@deepesh.india.tej
 asnetworks.com>
References: <20030719113722.1dab30c0.pochini@shiny.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a FAQ.  Yes it is possible, but you have to know EXACTLY what you
are doing to make it work.  The primary problem is memory mapping and SDRAM
initialization: you CANNOT do them while running out of RAM because it will
cause your program to "disappear".  Most people find it much easier to
program U-Boot into flash.

gvb


At 07:28 PM 7/19/2003 +0530, deepesh@india.tejasnetworks.com wrote:

>Hi,
>
>  I have an EP8260 board. I have the u-boot binary. The board comes with a
>boot loader(PlanetCore). I want to load u-boot into RAM and then start
>executing from there. Is this possible? I tried doing this, but the board
>goes for a reset.
>
>  CAN I START UBOOT AS AN APPLICATION FROM PLANETCORE BOOTLOADER? that is
>it possible to start one bootloader from another one?
>
>
>deepesh
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
