From: clark@esteem.com
Message-Id: <5.0.0.25.1.20010508130110.0207deb0@pop.esteem.com>
Date: Tue, 08 May 2001 13:28:40 -0700
To: Arturo Nunez <artnpp@cs.ucf.edu>
Subject: Re: Wireless Advice
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <200105081540.LAA10976@iris.cs.ucf.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 11:40 AM 5/8/01 -0400, you wrote:

>Hello:
>         I have the following board:
>
>         RPX CLLF
>         Cpu:XPC860TZ
>
>         From Embbeded Planet.
>
>         Now, I need to do some research in Wireless, I was thinking to
> use one of these cards:
>
>         -       Cisco Aironet 340 Series Card  or
>         -       Linksys WPC11
>
>         Any advice of which one use ??
>
>         Best Regards
>
>         Arturo Nunez
>

I asume you want to do 802.11 or 802.11b.

         I recomend you use a pcmcia card based on the prism 2 chipset. You
can get the driver for the prism 2 cards at http://www.linux-wlan.com .
They also have a list of cards they have tested with the driver. They also
sell an access point development kit. the development kit includes a RPX
lite board.

         Our company will be selling an access point and pcmcia cards soon
(as soon as we get the software finished ;-) ). Our access point will
operated at the legal power limit of 1 watt. The pcmcia cards we will be
selling put out about 100 milliwatts and we know they work with linux. If
your willing to wait check our site out http://www.esteem.com .


Good luck

Conn Clark



*****************************************************************
   If you live at home long enough, your parrents will move out.
*****************************************************************

Conn Clark
Engineering Stooge				clark@esteem.com
Electronic Systems Technology Inc.		www.esteem.com

(509) 735 - 9092 EXT. 15

Stock Ticker Symbol				ELST

"clark@esteem.com" Copyright 2000 all rights reserved. May not be sold or
used for advertisements.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
