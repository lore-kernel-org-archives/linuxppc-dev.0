Date: Wed, 17 Feb 1999 10:40:28 -0600 (CST)
From: Troy Benjegerdes <hozer@drgw.net>
To: Gabriel Paubert <paubert@iram.es>
cc: Cort Dougan <cort@persephone.cs.nmt.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Restructuring Efforts
In-Reply-To: <Pine.HPP.3.96.990217112942.26713B-100000@gra-ux1.iram.es>
Message-ID: <Pine.LNX.4.04.9902171028470.432-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



I propose that since a release of Bitkeeper is supposedly imminent, that
we attempt to make use of it for the PPC specific tree. This should be
closer to the 'patch' idea Cort wanted in the first place, and will most
definitely make things easier for Gabriel with his poor trans-atlantic
connection ;)

According to the bitkeeper mail list, there will most likely be a bunch of
bitkeeper mirrors of the official kernel, which would make it quite easy
for Gabriel to grab new updates to the new kernel and automatically
merge in the PPC devel changes.

On Wed, 17 Feb 1999, Gabriel Paubert wrote:

> On Tue, 16 Feb 1999, Cort Dougan wrote:
> 
> > I was thinking about that over the last few hours.  The cvs repository for
> > ppc could work.  I'd be happy to set one up and maintain the cvs tree
> > for ppc but I have a few problems with it.  1) I would have to move things
> > from our tree to vger then to linus.  I think testing things in vger is
> > pretty important since we get to find problems with other peoples code
> > coming in before it goes to Linus' tree - we can work on it there quickly
> > to solve the early problems.  2) The changes could come in way too
> > quickly.  We have incompatible patches out there now, but how would it be
> > having incompatible changes going into the linux/ppc cvs tree?  We'd have
> > a broken starting point rather than a working and reasonably stable one.
> > Bitkeeper might help here, but in essence it just ships patches (Larry
> > calls 'em deltas) around via smtp.
> > 
> > With metered (and well behaved :) changes going into a linux/ppc cvs tree
> > I think that wouldn't be a problem.  So I can get a handle on the scope of
> > things, how many people would want r/w access to a linux/ppc cvs tree?
> 
[snip]

> But who has access to vger lately ? I have been bitten very hard and
> switched back to Linus'tree because of this. I spent too much time in the
> switch, having to check around 600 files (ok, it made me very familiar
> with emacs ediff modes ;-)) and I don't want it to happen again.
> 
> Besides this, the mirrors in Europe make it easy for me to keep up to date
> with Linus's tree, while I couldn't keep up with vger. My effective
> bandwidth to the US is awful: who can say that surfing the web at any
> speed higher than 20 bytes/second is an exhilarating experience ? 
> 
> (Yes I mean twenty bytes per second or 160 baud, I've not forgotten any
> kilo/mega/gigha/tera/peta/exa prefix, wherever I have travelled in the
> last 3 years, the worst case was at least an order of magnitude faster
> than from here).
> 

--------------------------------------------------------------------------
| Troy Benjegerdes    |       troy@microux.com     |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
