Date: Thu, 18 Sep 2003 11:08:34 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: BOOT_TARGET pImage & uImage ???
Message-ID: <20030918180834.GC6692@ip68-0-152-218.tc.ph.cox.net>
References: <3F65917D.1020502@imc-berlin.de> <20030915150935.GB29517@ip68-0-152-218.tc.ph.cox.net> <3F699255.4050000@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3F699255.4050000@imc-berlin.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Sep 18, 2003 at 01:09:09PM +0200, Steven Scholz wrote:
> Tom Rini wrote:
>
> >On Mon, Sep 15, 2003 at 12:16:29PM +0200, Steven Scholz wrote:
> >
> >
> >>is the there any particular reason why the BOOT_TARGETS "pImage" and
> >>"uImage" for
> >>the famous boot loader PPCBoot and its successor U-Boot are still not
> >>supported.
> >>Neither by linux_2_4_devel. Nor by the vanilla.
> >
> >
> >For a third time:
> >http://www.geocrawler.com/archives/3/8358/2002/11/0/10241415/
>
> I have to admit that I don't understand what you're describing there. I am
> afraid nobody else did. Otherwise someone would realized it by now...

If I'm making requests and rambling at the same time, can people please
speek up sooner?  I won't mind, really.

What I want is three things:
1) The 'mkimage' target must be done in such a fashion that it will
never run into a 'cannot execute' problem.  My suggestion is to have the
Makefile do a:
@chmod +x mkimage.sh
Or so.  In 2.5/2.6, the build system will handle this for you,
automagically, on .sh files I believe.  For 2.4, you must handle this
explicitly.
2) Do we really need 'pImage' and 'uImage' or can we just have 'uImage'
?
3) I really (really!) want a patch for 2.4 and 2.5/2.6 at the same time.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
