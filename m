Date: Thu, 18 Sep 2003 11:28:32 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Brian Waite <waite@skycomputers.com>
Cc: Steven Scholz <steven.scholz@imc-berlin.de>,
	LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: BOOT_TARGET pImage & uImage ???
Message-ID: <20030918182832.GE6692@ip68-0-152-218.tc.ph.cox.net>
References: <3F65917D.1020502@imc-berlin.de> <3F699255.4050000@imc-berlin.de> <20030918180834.GC6692@ip68-0-152-218.tc.ph.cox.net> <200309181422.32546.waite@skycomputers.com>
Mime-Version: 1.0
In-Reply-To: <200309181422.32546.waite@skycomputers.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Sep 18, 2003 at 02:22:28PM -0400, Brian Waite wrote:
> > What I want is three things:
> > 1) The 'mkimage' target must be done in such a fashion that it will
> > never run into a 'cannot execute' problem. My suggestion is to have
> > the Makefile do a:
> > @chmod +x mkimage.sh
> > Or so. In 2.5/2.6, the build system will handle this for you,
> > automagically, on .sh files I believe. For 2.4, you must handle this
> > explicitly.
>
> Altough messy, I make this happen in the patch I supply. I can change
> it to do the straight chmod in the scrip[ts directory if that is
> cleaner.

I think what your patch does is the 2.6 logic, so that's probably best.

> > 2) Do we really need 'pImage' and 'uImage' or can we just have
> > 'uImage' ?
>
> I think uImage is enough. Wolfgang strongly discourages any use of
> PPCBoot these days and it just seems silly.

That what I figured at this point.

> > 3) I really (really!) want a patch for 2.4 and 2.5/2.6 at the same
> > time.
>
> This was one of the reasons for not supplying the patch previously. I
> will try to pull together a 2.5/2.6 patch but I have not worked under
> 2.5/2.6 at all. When I initially did the 2.4 patch I pulled the 2.5
> tree but I didn't have time to understand the layout. Also, unless
> someone has a board that will boot a uImage target I can only supply
> an untested patch. I'll take some time and see if I can pull something
> I am comfortable with in the next few days. Is there anyone who could
> help with testing?

'Untested' is fine here, since all you have to do to test is have the
'uImage' target work.  A minimal config based on arch/ppc/defconfig
should suffice for this.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
