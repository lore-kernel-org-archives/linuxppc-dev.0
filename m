Message-ID: <3CB6A2FE.62FFB14E@imc-berlin.de>
Date: Fri, 12 Apr 2002 11:03:58 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: sporadic kernel panic during boot (MPC8xx, FEC)
References: <Pine.LNX.4.44.0204110914100.18980-100000@sole.infis.univ.trieste.it> <3CB539DF.CF3BDD85@imc-berlin.de> <20020411153136.GE15663@opus.bloom.county> <3CB5DE9A.9070802@bluewin.ch> <20020411191258.GA2785@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > >No.  -rv2.4.18 got you 2.4.18 from kernel.org, no PPC changes at all.
> > You mean it's identical to linux-2.4.18.tar.gz from kernel.org?
> Yes.

Yes. Indeed. I just compared the two trees and got

/opt/linuxppc > dircmp -s devel_2_4_18 linux
2002-04-12 10:18       Comparison of devel_2_4_18 linux        Seite
1

different       ./fs/binfmt_elf.c
different       ./net/ipv4/udp.c


But I am still not sure if I understand what that means. Is there a
FAQ/README/HowTo about the LinuxPPC/Bitkeeper/Versionnumbering
somewhere?

Which ChangeSet or Tag stands for a stable PPC kernel?

Which ChangeSet equals (with regard to functionality) the official
linux-2.4.18 from kernel.org?

Does the ChangesSet 1.900 (which is shortly after Tag 2.4.18) contain
all the stuff that's in the offical kernel?

Thanks,

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
