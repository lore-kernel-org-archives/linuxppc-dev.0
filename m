Message-ID: <3CB539DF.CF3BDD85@imc-berlin.de>
Date: Thu, 11 Apr 2002 09:23:11 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Christian Pellegrin <chri@infis.univ.trieste.it>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: sporadic kernel panic during boot (MPC8xx, FEC)
References: <Pine.LNX.4.44.0204110914100.18980-100000@sole.infis.univ.trieste.it>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Christian Pellegrin wrote:

> not really sure this will help you, but I had similar problem (spurious
> hangs during boot/insmod on 823 and 850 MPCs). The ppc mm for 8xx in 2.4
> repository is broken, use that in 2.4-devel that works fine. AFA net
> devices are concerned check that rx start is done in open and not in init
> since linux doesn't like packets before a device is opened.

Thanks for your reply.

I got the kernel from the linuxppc_2_4_devel tree using

bk export ... -rv2.4.18

So I guess I do have a 2.4-devel. Right?

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
