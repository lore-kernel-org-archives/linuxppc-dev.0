Message-ID: <3CB5AEBC.D564B34C@imc-berlin.de>
Date: Thu, 11 Apr 2002 17:41:48 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: sporadic kernel panic during boot (MPC8xx, FEC)
References: <Pine.LNX.4.44.0204110914100.18980-100000@sole.infis.univ.trieste.it> <3CB539DF.CF3BDD85@imc-berlin.de> <20020411153136.GE15663@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:
> > I got the kernel from the linuxppc_2_4_devel tree using
> >
> > bk export ... -rv2.4.18
> >
> > So I guess I do have a 2.4-devel. Right?
>
> No.  -rv2.4.18 got you 2.4.18 from kernel.org, no PPC changes at all.

Well Tom,

I do a "bk pull" from http://ppc.bkserver.net/linuxppc_2_4_devel once in
a while.
And when I do a "bk export -r2.4.18 ..." I definetly get PPC stuff in
the resulting tree. Otherwise it would be easy to notice that there is
something strange!

Anyway, from noe on I try to remember not to use the tags but the
changeset to export the tree.

BTW does anyone know a good and easy way to get the changes from the
bitkeeper tree into a local CVS?
For now I "bk pull" then "bk export" and then "cvs import" and then
merge... :-(

Cheers,

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
