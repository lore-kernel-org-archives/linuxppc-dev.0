Date: Wed, 3 May 2000 00:18:01 -0500 (CDT)
From: Troy Benjegerdes <hozer@drgw.net>
To: Holger Bettag <hobold@Informatik.Uni-Bremen.DE>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Does a Cinema Display work under Linux?
In-Reply-To: <8xbt3w352n.fsf@s62.informatik.uni-bremen.de>
Message-ID: <Pine.LNX.4.10.10005030012120.30739-100000@altus.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 30 Mar 2000, Holger Bettag wrote:

>
> Holger Bettag <hobold@informatik.uni-bremen.de> writes:
>
> >
> > [I asked about the chances of a Cinema Display functioning with Linux/X11]
> >
> > On Tue, 14 Mar 2000, David A. Gatwood wrote:
> >
> [...]
>
> > > Worth mentioning, though, I'm using BootX, so it gets configured, at least
> > > to some degree, by MacOS.
> >
> >
> > And Tim Seufert wrote:
> >
> > > You can probably at least assume that you'll be able to use it
> > > unaccelerated at its native resolution via offb.
> >
>
> I have been loosely following the discussion about the new updated Sawtooth
> mainboards and noticed that several people seem to be unable to use BootX on
> those new machines.
>
> Now I must assume that a Cinema Display won't 'voluntarily' work under Linux.

Basically, the accellerated aty128 drivers don't recognize the digital
output. (I had this problem with a 15" digital flat panel).

I've heard that it may work with offb, but one is limited to whatever
resoultion OF happens to use.

-------------------------------------------------------------------------
Troy Benjegerdes          troy@blacklablinux.com            hozer@drgw.net


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
