From: mlocke@jps.net
Message-ID: <3A37B380.DFAAA77@jps.net>
Date: Wed, 13 Dec 2000 09:36:00 -0800
Reply-To: mlocke@mvista.com
MIME-Version: 1.0
To: Nguyen Xuan Hoang <jerry.nguyen@serialsystem.com.sg>
CC: linuxppc-embedded@lists.linuxppc.org, support@mvista.com
Subject: Re: PCMCIA have machine check
References: <3A37867B.2070606@galileo.co.il> <000801c06595$5f102540$ef0fa8c0@hoangmobile>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You probably have the old RPX bootloader.  It sets the Bus Montior timeout
which causes machine checks for every IO operation.  Contact EP tech support
and request PlanetCore, the new bootloader.
Nguyen Xuan Hoang wrote:

> Hi,
>
> I am trying to run Wireless Lan PCMCIA on RPXLite board,  but the system
> just randomly crash (a machine check error).  I have trace the error, it
> happen when we read or write the I/O port on the wireless LAN. It seems the
> PCMCIA controller not set correctly. Have anyone experience about this
> problem, please give me some advice.
>
> Thank in advance
> Jerry
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
