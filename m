From: clark@esteem.com
Message-Id: <5.0.0.25.1.20010108084955.00a7beb0@pop.esteem.com>
Date: Mon, 08 Jan 2001 10:00:45 -0800
To: Linux Lurker <linuxlurker@yahoo.com>
Subject: Re: Setup and Equipment needed for Linux on PowerPC
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20010108020303.17986.qmail@web11901.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 06:03 PM 1/7/01 -0800, you wrote:

>I'm trying to setup a shop to produce customized
>Linux Kernels on the PowerPC. What are my
>choices for the development box and what are
>the best burners and chips. What disribution of Linux
>is the best for PowerPC?
>
>

Hello Lurker,

         For developement many people use ordinary PC although, I have
heard of a few people using Macs and one lucky person using a Sun
workstation. (Note: All running Linux).

         For an embedded target you'll probably want a developement board
that is already supported by your distribution's kernel. A few common ones
supported are Motorola 's MBX860, Embedded Planet's RPX, BrightStar
Engineering. Check the particular distribution you want to use before you
buy. Stay Away From The Motorola Fads Boards!

         As far as distributions go there are many to choose from but I
suggest you stay away from ones that charge royalties. A few that don't
Hard Hat Linux,  Red Hat's Embedded Dev Kit. I belive Wolfgang Denk who
frequently answers questions on this list has his own distribution CD for
sale available at http://www.denx.de .

         Burrner? do you mean In Circuit Emulator (ICE) or debugger? If so
I have heard that the Abatron BDI2000 is the way to go. Most others don't
work after the MMU is turned on.

         To answer your question of what are the best chips. It depends on
what you are trying to do and if cost is an issue (Speed is just a matter
of money).

         If you intend to create a custom board check out motorola's and
IBM's web pages on embedded PPC processors and pick one that suits your
needs. Then find out if anyone else has used it and how it worked for them.
Then decide if you still want to use it. For developement of the boot rom I
recommend looking at the ppcboot project at http://ppcboot.sourceforge.net/ .

         here are some helpfull links

http://www.mvista.com/

http://members.nbci.com/greyhams/linux/PowerPC-Embedded-HOWTO.html

http://e-www.motorola.com/webapp/sps/prod_cat/taxonomy.jsp?catId=M934304420796

http://www.embeddedplanet.com/

http://linuxppc.org/

         Good Luck
                 Conn Clark
*****************************************************************
   If you live at home long enough, your parrents will move out.
*****************************************************************

Conn Clark
Engineering Stooge				clark@esteem.com
Electronic Systems Technology Inc.		www.esteem.com

Stock Ticker Symbol				ELST

"clark@esteem.com" Copyright 2000 all rights reserved. May not be sold or
used for advertisements.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
