From: mlocke@jps.net
Message-ID: <3A37B3D5.70D6E406@jps.net>
Date: Wed, 13 Dec 2000 09:37:25 -0800
Reply-To: mlocke@mvista.com
MIME-Version: 1.0
To: Nguyen Xuan Hoang <jerry.nguyen@serialsystem.com.sg>
CC: linuxppc-embedded@lists.linuxppc.org, support@mvista.com
Subject: Re: PCMCIA have machine check
References: <3A37867B.2070606@galileo.co.il> <000801c06595$5f102540$ef0fa8c0@hoangmobile>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


forgot one thing.  Once you have the new bootloader, you will need to
disable the BMT in the SYPCR register.

Nguyen Xuan Hoang wrote:
>
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
