Date: Wed, 3 May 2000 10:43:54 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: Troy Benjegerdes <hozer@drgw.net>
cc: Holger Bettag <hobold@Informatik.Uni-Bremen.DE>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Does a Cinema Display work under Linux?
In-Reply-To: <Pine.LNX.4.10.10005030012120.30739-100000@altus.drgw.net>
Message-ID: <Pine.LNX.3.96.1000503104007.24757G-100000@deepspace.mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 3 May 2000, Troy Benjegerdes wrote:

> > I have been loosely following the discussion about the new updated Sawtooth
> > mainboards and noticed that several people seem to be unable to use BootX on
> > those new machines.

I believe they determined that it was a bug in the ROM image included with
MacOS 9.0.4.  If you're having this problem you might want to grab an
older ROM image from somebody for whom BootX does work.  :-)


> > Now I must assume that a Cinema Display won't 'voluntarily' work under Linux.
>
> Basically, the accellerated aty128 drivers don't recognize the digital
> output. (I had this problem with a 15" digital flat panel).
>
> I've heard that it may work with offb, but one is limited to whatever
> resoultion OF happens to use.

I've been doing it w/ the no video drivers setting and Xpmac.  Obviously,
you're limited with whatever res you were in with MacOS, but that's not
_that_ big a problem, since at least the studio displays only offer one
resolution. I would expect the Cinema displays to be similar, but I'm not
sure.


Later,
David

---------------------------------------------------------------------
A logician trying to explain logic to a programmer is like a cat
trying to explain to a fish what it's like to be wet.

	-- unknown, possibly Franklin Veaux


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
