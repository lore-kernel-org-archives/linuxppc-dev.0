Message-ID: <3690785B.34A0CB72@wanadoo.fr>
Date: Mon, 04 Jan 1999 09:14:19 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Hollis R Blanchard <hollis+@andrew.cmu.edu>
CC: Sam Quigley <osquigle@cs.uchicago.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: FTP Problems
References: <Pine.LNX.3.96L.990103184911.3513C-100000@unix49.andrew.cmu.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hollis R Blanchard wrote:
> 
> On 3 Jan 1999, Sam Quigley wrote:
> 
> > > OK, so it can't open the RPMS database, right? Can you switch to virtual
> > > console 3 (Cmd-F3) or 4 and see if there's a specific error listed? That
> > > might be a little more helpful than the installer errors message.
> >
> > I have this problem too: the error reported is, on console 3:
> >
> > * ugFindUpgradePackages() ...
> > * failed opening /mnt/var/lib/rpm/packages.rpm
> >
> > the installer warns that 'an error occurred during step "Choose
> > packages to upgrade"', but also has a stray line reading
> > "/mnt/var/lib/rpm/nameindex.rpm:" on the background.  (this is,
> > presumably, an error message from something other than the installer)
> >
> > I can cat packages.rpm fine from the console.

I saw such error messages when the installer had some mount problems. I
think they went away with the glibc-2.0.108 libraries. But I am not sure
about this.
 
> Hmm. I am *not* an expert on the RedHat installer, but what's in packages.rpm?
> And how about nameindex.rpm?
> 
> I expect we'll get a little help once people get settled after MacWorld. Which
> reminds me, I was hoping I could get a list of the various people working on
> R5 and what they're doing. Just curious, plus it would make it easy to have a
> dialogue with the person(s) working on the RedHat installer.

This might be a good idea, but seeing how they have worked in the past,
my guess is that they already have some (almost) finished perfectly
working installer sitting around somewhere but didn't have the time to
copy it to the right place. So we shouldn't get heated up too much about
this question.
 
> Martin's ramdisks don't *fix* anything, they just give you the tools you need
> so *you* can fix it.

Yes, thank you, Hollis, that's what I intended. I am just a dumb user
like everyone else here in this thread. I just happened to spend some of
my Xmas holidays on trying to figure out how these ramdisk images are
constructed. And I managed to install pre-R5 some time ago using the
supp.img floppy.

But now holidays are over, I have to go back to work. 

See you later
--
Martin

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
