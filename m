Date: Tue, 24 Jul 2001 19:40:13 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: "Joseph P. Garcia" <jpgarcia@execpc.com>
Cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: userspace button controls
In-Reply-To: <20010724112100.6e00124c.jpgarcia@execpc.com>
Message-ID: <Pine.LNX.4.10.10107241929170.17961-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Michael Schmitz <schmitz@mail.biophys.uni-duesseldorf.de> wrote:
> > You're talking about PMU_IOC_SET/GET_BACKLIGHT? Thanks for breaking pmud
> > :-) Please make that a config option, or get Stephan Leemburg to change
> > pmud before this leaks into kernels built for the unsuspecting user.
>
> Oh yeah.  That's right. ^_^;  When I get the time, I'll see what I can
> do.  The patches are for testing purposes.  As Franz pointed out,
> there are a few things that need to be done before anything can be

With the 2.4 development kernels being used by many (for good reason), I'm
sure we'll see bug reports on this within weeks of including this feature
in, say, BenH's kernel tree.

> In the meantime, kernel space coexistance of the two would be nasty.
> I coded this thinking i need cleaner code over maintaining the older
> code links in the kernel.

:-) While this is a Good Thing, introducing it somewhere along 2.4 will
cause trouble. But I see I won't convince anyone here. I'll forward bug
reports related to such breakage here.

> For testing, a 'if(ioctl(pmu,...)<0) ioctl(fb,...);' should work for
> compatibility, taking with the -EINVAL ioctl failure my patch would
> generate.  Probably put the fb's ioctl in an #ifdef (IOCTL NAME) so it
> still compiles elsewhere.

I don't doubt it can be taken care of in future pmud releases. That just
won't help J. Random User who just wants to try that cool new kernel with
userspace gizmo button support. Users Don't Read Documentation.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
