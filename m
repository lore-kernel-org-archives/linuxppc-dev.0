Date: Thu, 11 Apr 2002 09:18:40 +0200 (CEST)
From: Christian Pellegrin <chri@infis.univ.trieste.it>
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: sporadic kernel panic during boot (MPC8xx, FEC)
In-Reply-To: <3CB53640.9B0DD9B4@imc-berlin.de>
Message-ID: <Pine.LNX.4.44.0204110914100.18980-100000@sole.infis.univ.trieste.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 11 Apr 2002, Steven Scholz wrote:

>
> Hi there,
>
> I am using the linux kernel from bitkeepers linuxppc_2_4_devel exported
> as of -rv2.4.18 on a MPC855T based board.
>

...

>
> Any ideas?
>
> Thanks,
>

not really sure this will help you, but I had similar problem (spurious
hangs during boot/insmod on 823 and 850 MPCs). The ppc mm for 8xx in 2.4
repository is broken, use that in 2.4-devel that works fine. AFA net
devices are concerned check that rx start is done in open and not in init
since linux doesn't like packets before a device is opened.

Bye!


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
