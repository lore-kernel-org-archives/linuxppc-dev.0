From: clark@esteem.com
Message-Id: <5.0.0.25.1.20001213090208.00a6a230@pop.esteem.com>
Date: Wed, 13 Dec 2000 09:15:41 -0800
To: "Nguyen Xuan Hoang" <jerry.nguyen@serialsystem.com.sg>
Subject: Re: PCMCIA have machine check
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <000801c06595$5f102540$ef0fa8c0@hoangmobile>
References: <3A37867B.2070606@galileo.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Jerry,

         We had a similar problem with our design. The PCMCIA_WAIT signal
was stuck low. However since you are a comercial board I doubt that this is
the case, but you might want to look at it anyway.

         My gut instinct tells me you may have some more work to do in
m8xx_pcmcia.c .

         Sorry I can't be more help.

         Conn Clark


At 10:16 PM 12/13/00 -0800, you wrote:

>Hi,
>
>I am trying to run Wireless Lan PCMCIA on RPXLite board,  but the system
>just randomly crash (a machine check error).  I have trace the error, it
>happen when we read or write the I/O port on the wireless LAN. It seems the
>PCMCIA controller not set correctly. Have anyone experience about this
>problem, please give me some advice.
>
>Thank in advance
>Jerry
>
>

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
