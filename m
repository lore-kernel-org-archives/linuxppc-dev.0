Message-ID: <3FC53EC3.4060302@g-house.de>
Date: Thu, 27 Nov 2003 01:01:07 +0100
From: Christian Kujau <evil@g-house.de>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.6 PReP fix? (Was: [jgarzik@pobox.com: [PATCH/CFT] de2104x fixes])
References: <20031126203131.GJ2541@stop.crashing.org> <3FC537B5.80504@g-house.de>
In-Reply-To: <3FC537B5.80504@g-house.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Christian Kujau wrote:
>
> Tom Rini wrote:
>
>> Ok, here's a better patch.  It's against 2.6.0-test9-BK-latest
>> (currently bk25).
>
>
> [...]
>
> i don't have a -bk tree here, so i get a .rej with -test9 and -test10:
>
> evil@sheep:/usr/src/linux-2.6$ cat /data/Incoming/de2104x.c.diff |  \
> patch -p1 --dry-run
> patching file drivers/net/tulip/de2104x.c
> Hunk #6 FAILED at 1569.
> 1 out of 7 hunks FAILED -- saving rejects to file
> drivers/net/tulip/de2104x.c.rej
> evil@sheep:/usr/src/linux-2.6$
>

but it seems to compile:


   CC      drivers/net/net_init.o
   CC      drivers/net/loopback.o
   CC [M]  drivers/net/tulip/de2104x.o
   CC [M]  drivers/net/tulip/eeprom.o
   CC [M]  drivers/net/tulip/interrupt.o
   CC [M]  drivers/net/tulip/media.o
   CC [M]  drivers/net/tulip/timer.o
   CC [M]  drivers/net/tulip/tulip_core.o
   CC [M]  drivers/net/tulip/21142.o
   CC [M]  drivers/net/tulip/pnic.o
   CC [M]  drivers/net/tulip/pnic2.o
   LD [M]  drivers/net/tulip/tulip.o
   CC [M]  drivers/net/tulip/de4x5.o
   LD      drivers/net/built-in.o
   CC [M]  drivers/net/3c59x.o


(compile will finish soon, but have to to sleep now, ...blip..)
Christian.

--
BOFH excuse #20:

divide-by-zero error


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
