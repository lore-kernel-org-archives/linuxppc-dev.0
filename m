Message-ID: <027d01c15f9d$65086e00$230d8b3d@ming>
From: "Chen Yaoming" <ymchen@ocdtt.com>
To: "Martin, Tim" <tim.martin@viasat.com>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <B2FEA4881D7DD411BFDC000629A819D802BC2D4A@POSTAL>
Subject: Re: Multiple MPC8xx SCC ethernets
Date: Sun, 28 Oct 2001 18:43:34 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Horiuchi Satoshi had sent me his patch before. After I patched
to 2.4.12, then to 2.4.13, it worked smoothly. There are three
main modifications. One is in drivers/net/setup.c, adding the
second SCC enet setup entry. The second is in arch/ppc/8xx_io/
Config.in, adding the config option. The last is in enet.c,
adding the second SCC init code, set_muticast_list and interupt
handler, which looks like the first SCC code very much except the
SCC numbers.

A more elegant scheme is needed to figure out, I think.

----- Original Message -----
From: "Martin, Tim" <tim.martin@viasat.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Saturday, October 27, 2001 6:36 AM
Subject: Multiple MPC8xx SCC ethernets

> I'm looking for patches to allow multiple SCC based ethernets on MPC8xx
> based boards.  The 2.4 kernel releases only allow selection of either SCC1,
> SCC2, or SCC3, but not all three at the same time.
>
> Twice in the last few months, there's been a thread discussing this but I've
> never seen any code posted to the list.  Could someone send me / point me to
> any available patches?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
