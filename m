Date: Thu, 11 Apr 2002 10:46:55 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: The very common kernel, again...
Message-ID: <20020411174655.GD19157@opus.bloom.county>
References: <20020411170356.GB19157@opus.bloom.county> <0204111731.AA29012@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0204111731.AA29012@ivan.Harhan.ORG>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Apr 11, 2002 at 10:31:13AM -0700, Michael Sokolov wrote:
>
> Tom Rini <trini@kernel.crashing.org> wrote:
>
> > Why?  Why is it a good thing to put this into 'CONFIG_ALL_PPC' ?  You
> > still end up with 3 images (PReP, vmlinux for pmac/chrp, PPCStar) which
> > I wouldn't think is any worse from N (either the FW lets you load an
> > abitrary kernel off of the CD/HD/whatever, or you have to put on the
> > !vmlinux (in CONFIG_ALL_PPC's case, yaboot) booting kernel else-where.
>
> But we wouldn't have this mess if you guys would just let us have one
> CONFIG_GENERIC_PPC32 vmlinux with a standardized and stable boot ABI. Then we,
> the people with incentive to sell boards, would do what we need to do with our
> firmware or booters or whatever to boot that standard vmlinux and make it as
> easy as possible for people like Debian to support us in the standard dist.

This has _nothing_ to do with the boot ABI.  The boot ABI for 2.4 hasn't
changed, as far as I can remember anyhow.  The plan for 2.5 is to come
up with and agree upon once and for all (and it seems that it's been
mostly done too).  The question I asked is why do you want to make a
vmlinux that runs on large groups of totally unrelated, save for a CPU
family, mostly, group of computers.

If someone really wanted, they could put 8xx and 4xx into this mess too,
with some complex asm, and have 1 kernel that boots on 4xx/6xx/7xx/74xx/8xx.
I doubt it'd be useful, but it could be done.

>
> MS
>

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
