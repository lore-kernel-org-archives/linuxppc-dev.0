Message-ID: <3ADDAF55.308E1014@iiic.ethz.ch>
Date: Wed, 18 Apr 2001 17:14:29 +0200
From: Michel =?iso-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: Alain RICHARD <alain.richard@equation.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: benh 2.4.4-pre3, Titanium and AirPort
References: <a05010404b703232d1b66@[192.168.240.10]>
	 <20010418115224.25139@mailhost.mipsys.com> <a05010406b7033c861041@[192.168.240.10]>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Alain RICHARD wrote:

> I have built PCMCIA in the kernel, but the problem is that to load
> orinico_cs, we must first load the PCMCIA support because it depends
> on ds that depends on a working pcmcia adaptor driver (i82365 in
> previous powerbooks).
>
> The problem seems that i82365 seems not recognizing the cardbus on
> titanium. lspci output is :
>
> 01:1a.0 CardBus bridge: Texas Instruments PCI1211
>          Flags: bus master, medium devsel, latency 16, IRQ 58
>          Memory at 80080000 (32-bit, non-prefetchable) [size=4K]
>          Bus: primary=01, secondary=02, subordinate=05, sec-latency=32
>          I/O window 1: 00000000-00000003
>          16-bit legacy interface ports at 1011

I have the same on my Pismo and I use the yenta_socket module. I'm writing
this from an Airport connection. :)


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
