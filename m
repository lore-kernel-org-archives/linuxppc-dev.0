Mime-Version: 1.0
Message-Id: <v0421010ab406d1babd5a@[17.203.21.242]>
In-Reply-To: <37E0D87F.E8F2087A@usa.net>
References: <Pine.LNX.4.10.9909151555260.31363-100000@opus.bloom.county>
 <37E0A14A.E4217C4@madflower.com> <37E0D87F.E8F2087A@usa.net>
Date: Thu, 16 Sep 1999 10:05:26 -0700
To: happyoscar42@usa.net
From: Kevyn Shortell <kevyn@apple.com>
Subject: Re: New booter-New world
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Take prior events as an example, If we are working on something
such as this, it may likely never make it back to older machines,
so your still stuck with less than optimal open firmware on a majority
of machines your trying to run on.

So....if you want to be guaranteed to boot, you do it the recommended
way that the hardware is expecting, and I don't care if it offends
you and you think it's a kludge, there are limitations that you need
to operating within, and if you try and play all the little my solution
is holy than thou games, OF will break you.

It's not a matter of which solution is better, it's a matter of
existing within the limitations of the hardware at hand.

And this is the last I'll post on this.

Kevyn


At 7:46 AM -0400 9/16/99, David Riley wrote:
>Sean wrote:
> >
> > Since the New World machines have a flashable ROM, why doesn't Apple
> > just write a new flash ROM for MacOS X by writing a flash with
> > bootloader on it that stores its information in the MBR or PRAM
> > (multiple PRAM settings) or somewhere so they don't have to use the
> > secret partition trick to get MacOS X to boot correctly. In the process,
> > they might as well add an allowance so you can boot Linux or another
> > alternative OS in the extra slots (multiple kernels, etc). And the
> > ability to pick which OS you prefer to boot.
>
>It's quite possible that this is being worked on, because I can't
>imagine that Apple wants to do that thing with an HFS partition if they
>don't have to.  They're not just lazy bums out there, ya know. ;-)  If
>they are working on that, it's probably just undisclosed.
>
>--
>--"Your mouse has been moved.  Windows 95 must be restarted for change
>to take effect."

---------------------------------------------------------------
Kevyn Shortell                    Worldwide Developer Relations
Technology Manager          	  Apple Computer, Inc
kevyn@apple.com                   http://developer.apple.com/
"War doesn't determine who's right. War determines who's left"

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
