Date: Sat, 20 Oct 2001 17:15:17 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Paul Mackerras <paulus@samba.org>
Cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: arch/ppc/kernel clutter
In-Reply-To: <15313.12899.480254.317750@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.10.10110201710380.2994-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > I was wondering how you guys could live with that situation anyway. Why
> > not have arch/ppc/powermac/, arch/ppc/prep/, arch/ppc/chrp/ and more of
> > the same?
>
> We had that at one stage and decided that it was better to have
> powermac, prep and chrp in one directory.  Having a directory per
> platform would give us a lot of directories each with only a couple of
> files, which I don't want to see.

Well, I suppose it's a matter of taste. Even collecting the *_setup.c
etc. files in a new directory would cut down on the clutter enough :-)

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
