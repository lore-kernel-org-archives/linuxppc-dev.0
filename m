From: acurtis@directvinternet.com
Reply-To: <acurtis@directvinternet.com>
To: "Jim Mesenbrink" <mesenb@vss.fsi.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: booting Linux on est8260 using FCC2
Date: Tue, 15 Oct 2002 20:26:18 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFOEHLDNAA.acurtis@directvinternet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3DAC8A12.8090600@vss.fsi.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I have an EST SBC8260 board that I am trying to boot Linux using the
> FCC2 interface.  I am using ppcboot 1.2.0 and Linux 2.4.20-pre10.  I get
> as far in the boot process as:
>
>     IP-Config: Complete:
>           device=eth0, addr=10.0.0.8, mask=255.255.255.0, gw=10.0.0.1,
>          host=est8260, domain=, nis-domain=(none),
>          bootserver=10.0.0.62, rootserver=10.0.0.62, rootpath=
>     NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
>     Looking up port of RPC 100003/2 on 10.0.0.62
>
> After which the board goes silent.  I've placed a sniffer on the same
> net to verify that the board stops talking.  If I use the slower SCC
> ethernet interface everything works fine.  I have tried setting the port
> to half duplex on my switch without any luck.  I looked at the clock
> settings etc. in fcc_enet.c after reading a reply posted by Allen Curtis
> in regards to this exact situation, "Booting Linux Kernel on a EST8260",
> posted by another user.  I quickly realized I wasn't sure what I should
> exactly be looking for.  This issue also appears in the posting
> "root=/dev/nfs on sbc8260".  Any ideas would be greatly appreciated.

What FCC interfaces do you have configured into the kernel? Wouldn't FCC2 =
eth1?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
