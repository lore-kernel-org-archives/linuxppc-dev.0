Date: Wed, 15 Sep 1999 22:21:59 -0600 (MDT)
From: Dan Burcaw <dburcaw@terraplex.com>
To: Ethan Benson <erbenson@alaska.net>
cc: erik cameron <cameron@senta.uchicago.edu>,
        Kevyn Shortell <kevyn@apple.com>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: New booter
In-Reply-To: <v04210104b40612fb095b@[192.168.0.1]>
Message-ID: <Pine.LNX.4.10.9909152212520.19873-100000@newhope.terraplex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



> BOTH options should be available, for some syslinux/loadlin is more 
> convenient, for others LILO is a much nicer solution, especially in 
> its ability to load an arbitrary OS it knows nothing about by simply 
> loading that OSes bootblock!
> 
> > > I disagree
> >
> >maybe not some versions, currently.  and maybe at some point it won't be
> >kludgy at all.  but what's more kludgy, BootX or a small HFS partition that
> >nobody knows is there?  parts of linux *are* still kludgy; this is true.  I
> >disagree with the assertation that it is "more kludgy than anything else
> >on the planet," but i'd prefer it to be ugly and work than beautiful and
> >useless.
> 
> Linux does have kludges, I do not deny that, but for the most part 
> the kludges are unavoidable, and often accompanied by very colorful 
> comments in the source leading to censorship issues in australia :-)
> 
> the point it Linus and most linux developers PREFER to do things 
> right, to implement the cleanest and most efficient way that can be 
> done, but often times hardware makers leave stupid bugs in or create 
> a shortsighted design that simply does not work well in the long term 
> or does not work well outside of the small context the maker had in 
> mind, those are places where linux has to kludge its way in, but its 
> not prefered and only done if there is no other option.
> 
> my objections are twofold:
> 
> 1) I want ALL avenues of true OF booting by way of the bootblock to 
> be explored before giving up and implementing the second best 
> alternative, which is partitions and fake macos et al.

Not going to happen. Do you think we've come to this conclusion for any
other reason then because it's the best solution that we can come up with?
Are responses from Apple engineers not proof enough that this is the best
bet?

> 2) I am simply very frustrated that apple is being so shortsighted in 
> its design of OF and its boot process, they make it so specific to 
> MacOS they themselves have challenges getting OSX to boot on their 
> own machines! and later on HFS+ will be a obsolete filesystem and 
> they will want to replace it again the desisions to make the boot 
> process so dependant on HFS is going to haunt them as much as it 
> gives migraines to developers of alternative OSes.

Well complain to them, not us.. leadership@apple.com. 

> I am not yet convinced there are no other options, the options have 
> hardly been explored, if there is indeed NO POSSIBLE WAY IN HELL to 
> boot these machines without a partition hack then fine, but I am not 
> yet satisfied we are to that point, I have been spending alot of time 
> investigating this myself, but everytime i try and enlist any 
> assistence to explore the issue further everyone seems to just say 
> `use bootx' or `just make a kludge partition'  those options are fine 
> for some situations and if fixing quik is indeed futile, but I just 
> want to make SURE there is not a BETTER way!

We've been exploring the possibilities since the first new world box came
out (iMac). Don't you think Apple would have done it "that way" if it was
possible? I don't know why they designed OF how they did, nor am I
justifying the implimentation, but it's what we have to work with, period.
If there IS a better way, the two Apple engineers on this list which have
been participating in this discussion don't know about it. 

> > > the bootstrap process should have NO reliance on a specific filesystem!
> >
> >and the more vehemently you criticize, the more people are expecting to see
> >you post a workaround that meets your aesthetic standards.
> 
> I have already stated several times how I think the boot process 
> should be designed so that it can be truely filesystem agnostic and 
> allow a LILO like system with all the niceties like password 
> protection, multibooting, multiple images, all in a nice clean 
> asthetically pleasing way.

LILO is asthetically pleasing and clean? 

I'm not arguing with you, just pointing out the fact that some of us have
been there, done that as far as researching this topic. Ben began work on
miBoot because this is the logical and best solution with what we have to
work with. (and there is an obvious need for a working bootloader for old
& new world boxes)

Regards,
Dan

Terra Soft Solutions, Inc.
   Yellow Dog Linux
   "The Ultimate Companion for a Dedicated Server"
   http://www.yellowdoglinux.com/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
