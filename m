Date: Sun, 20 Jul 2003 21:14:49 -0400
From: Ryan Boder <icanoop@bitwiser.org>
To: Owen Stampflee <owen@stampflee.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Trouble with 2.6.0-test1 on ibook2
Message-ID: <20030721011449.GA25473@bitwiser.org>
References: <20030718014622.GA5430@bitwiser.org> <1058740445.31388.89.camel@teron.lan.stampflee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1058740445.31388.89.camel@teron.lan.stampflee.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jul 20, 2003 at 03:34:28PM -0700, Owen Stampflee wrote:
> > Has anyone been running the devel kernel on an ibook2? Can anyone give me
> > pointers on how to debug or work around this problem when I finish
> > reinstalling?
> I'm running 2.6.0-test1 from linuxppc-2.5 on my M3 equipped iBook2 and
> it seems to be working okay.
>
> My guess is that you're probably missing CONFIG_FRAMEBUFFER_CONSOLE
> (Graphics -> Console display).

I got it working by using the pmac defconfig and just modifying that. I
suppose a smarter person would have done that in the first place instead of
just doing the config from scratch.

I'm still having an issue with the devel kernel and XFree86, but the airport
driver is working and that's what I'm interested in working on so I guess
I'm OK.

Thanks for the help,
--
Ryan Boder
http://www.bitwiser.org/icanoop

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
