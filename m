Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.213.223.res-cmts.eph.ptd.net
	[24.152.213.223]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 367F2DDEE3
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 May 2007 15:00:53 +1000 (EST)
Message-ID: <464A8F8A.8090006@dlasys.net>
Date: Wed, 16 May 2007 00:58:50 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: techie mj <mjtechie@gmail.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Help need for WindRiver EST SBC8260 Board
References: <9f6a4d400705151112y60d92a24l7d7bb05eb38658ed@mail.gmail.com>
In-Reply-To: <9f6a4d400705151112y60d92a24l7d7bb05eb38658ed@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

techie mj wrote:
> Hi All,
>
> For my project work(Packet filter) we are planning to buy a used
> WindRiver
> EST SBC8260 board
    The board you purchase should as closely as possible resemble your
actual product/target.
    Alot depends on what you are actually trying to accomplish.

    If you are working towards a manufacturing a custom piece of
hardware of your application,
    Then similarity of hardware is of high importance.
    And it may be likely that you have to create or buy a BSP for your
taget - particularly if
    you are supporting multiple OS's.

    If you are doing fairly generic work and the target is the OS's, not
the specific hardware,
    then find a board that is already supported by all the OS's you are
after.

    Before Pico had any of their boards available, I used a Mac Lombard
powerbook I purchased on
    eBay as a target. It was cheap, and runs Linux surprisingly well.
      
> I am new to this. So i request everyone to suggest me what i should
> look for
> while buying the board.My development environment will be LINUX may be
> vxworks in future.
   
>
> 1) My dealer is providing only the Board. ( 4MB-SIMM flash,16MB-SDRAM
> DIMM,
> 8kb- 8 bit EEPROM, 2MB- 8 bit Flash, 4MB SDRAM (Local Bus), RS-232,
> 10/100
> Base-TX Ethernet)
>    Is it enough -or whether i need any extra addon cards
 
    Again it depends on what you are trying to accomplish.
    The first "embedded" system I worked on had 256 bytes of memory, had
a 1Mhz clock,
    and toggle switches.

    The more minimal the hardware in resources and performance the more
difficult the
    development process tends to be.

>
> 2) Do i need to buy JTAG debugger or any
>    Is it possible to debug the code without JTAG/BDM
    Same as hardware and resources. I do not have a BDM. Many on this
list would think I am crazy.
    I have worked with very powerful debugging tools - but very very
often, all they do is overload you with data.
    On occasion they can be very convenient. But most of the time the
FIRST thing I do starting with new hardware
    is find some way of generating output - usually in the least number
of assembler instructions possible.
    One is really really nice - give me an LED and a bit to flash it and
I can debug anything.
    I needed little more than a virtual LED and printf's to get Linux
working on my target.
    But I had issues with GreenHills Integrity that required both a JTAG
as well as a minimal handwritten software debugger.

>
> 3) what are the cables i need
>
> 4) Can i directly download the bootcode from my PC to the Board through
> ethernet/serial port
>
> 5) Can anyone provide me the user manual for the above board. any
> weblinks
> are also good
>
> 6) any other points
>
> Thanks
> mjose
>
> ------------------------------------------------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
