Date: Wed, 17 Feb 1999 11:53:40 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Cort Dougan <cort@persephone.cs.nmt.edu>
cc: Troy Benjegerdes <hozer@drgw.net>,
        Christian Zankel <zankel@tarantel.rz.fh-muenchen.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Restructuring Efforts
In-Reply-To: <Pine.LNX.3.96.990216232757.32682C-100000@persephone.cs.nmt.edu>
Message-ID: <Pine.HPP.3.96.990217112942.26713B-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Tue, 16 Feb 1999, Cort Dougan wrote:

> I was thinking about that over the last few hours.  The cvs repository for
> ppc could work.  I'd be happy to set one up and maintain the cvs tree
> for ppc but I have a few problems with it.  1) I would have to move things
> from our tree to vger then to linus.  I think testing things in vger is
> pretty important since we get to find problems with other peoples code
> coming in before it goes to Linus' tree - we can work on it there quickly
> to solve the early problems.  2) The changes could come in way too
> quickly.  We have incompatible patches out there now, but how would it be
> having incompatible changes going into the linux/ppc cvs tree?  We'd have
> a broken starting point rather than a working and reasonably stable one.
> Bitkeeper might help here, but in essence it just ships patches (Larry
> calls 'em deltas) around via smtp.
> 
> With metered (and well behaved :) changes going into a linux/ppc cvs tree
> I think that wouldn't be a problem.  So I can get a handle on the scope of
> things, how many people would want r/w access to a linux/ppc cvs tree?

I never wanted r/w access to vger, but I would probably ask for one on a
PPC specific tree.  But I don't see why changes specific to arch/ppc have
to go to vger first, at least in a development tree which is supposed to
break occasionally (and vger was regularly merged with Linus'patches). Do
not forget that with the long list of mirrors of Linus'tree, these kernels
get a much larger public exposure. 

> I believe the number of patches floating around that can go into the
> main kernel are in the single digits.  There's quite a bit of overlap in
> them I'm pretty sure.  I see the patches as a system for fleshing out
> problems before I move them into vger. 

No problem with this. 

> We can do that with vger.  There's no reason vger has to be the same as
> Linus'.  That is, the ppc specific parts of the tree only.

But who has access to vger lately ? I have been bitten very hard and
switched back to Linus'tree because of this. I spent too much time in the
switch, having to check around 600 files (ok, it made me very familiar
with emacs ediff modes ;-)) and I don't want it to happen again.

Besides this, the mirrors in Europe make it easy for me to keep up to date
with Linus's tree, while I couldn't keep up with vger. My effective
bandwidth to the US is awful: who can say that surfing the web at any
speed higher than 20 bytes/second is an exhilarating experience ? 

(Yes I mean twenty bytes per second or 160 baud, I've not forgotten any
kilo/mega/gigha/tera/peta/exa prefix, wherever I have travelled in the
last 3 years, the worst case was at least an order of magnitude faster
than from here).

> Similar to what I was aiming at with the pci config access stuff and got
> closer to with the current irq.c, right?  I'm trying to do the shaking of
> all the patches for restructing to see what comes out.  Corey's work (along
> with others) does look good.

I'm currently running a kernel with Corey+Troy+prepboot+ a few patches of
mine. I'm going to upload the patch soon, once I split it into 3 parts
(prepboot+vme+rest, vme is being completely restructured so it won't be
there). 

	Gabriel


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
