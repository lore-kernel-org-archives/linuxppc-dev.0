Date: Sat, 15 May 1999 20:24:06 -0600 (MDT)
From: Dan Burcaw <dburcaw@terraplex.com>
To: Beecher Greenman <rbg6038@ritvax.isc.rit.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: DR Install Question
In-Reply-To: <01JB8P880QNEE96CRP@ritvax.isc.rit.edu>
Message-ID: <Pine.LNX.3.96.990515202319.25854A-100000@newhope.terraplex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 15 May 1999, Beecher Greenman wrote:

> >Try just assigning one swap partition while in the installer. Once you
> >have linux up and running you can manually setup the other swap partitions
> >for use. Make sure the one swap partition is named 'swap'.
> 
> The problem is that I can't assign any swap partitions at all. In 
> previous installers there was a dialog which listed all of the partitions 
> which could be used for swap, and you could use checkboxes to determine 
> which comes up. In the DR installer, this dialog never appears.

Then this is a feature that Red hat has removed. Probably to make the
installer more of a "wizard" and detect your swap partition for you.

> 
> >> Didn't seem to work, plus I have three partitions that I want to use for 
> >> swap. Perhaps I should try putting them on a different drive; the drive I 
> >> currently have them on also contains Darwin (which works fine on a PTPro, 
> >> by the way), and Darwin creates a whole slew of partitions.
> >
> >Try just assigning one swap partition while in the installer. Once you
> >have linux up and running you can manually setup the other swap partitions
> >for use. Make sure the one swap partition is named 'swap'.
> >> -Beecher Greenman
> >> >
> >> >Naming the partition swap worked for me, though it's not a pretty 
> >> >solution...
> >> >
> >> >Could some one fix this? or at least document it?
> >> >
> >> >--
> >> >>From: Beecher Greenman <rbg6038@ritvax.isc.rit.EDU>
> >> >>To: linuxppc-user@lists.linuxppc.ORG
> >> >>Subject: DR Install Question
> >> >>Date: Sat, May 15, 1999, 1:37 PM
> >> >>
> >> >
> >> >>
> >> >> This is a dumb question, probably, but I can't figure it out.
> >> >>
> >> >> I'm trying to install the devloper release. I've had previous experience
> >> >> installing February, R4, pre-R5, and Yellow Dog Champion 1.0. But for the
> >> >> life of me, I can't figure out how on Earth to assign swap partitions in
> >> >> the developer release's installer. This is rather annoying, because it
> >> >> says I need to assign them before I can continue past the screen where
> >> >> the mount points are assigned. The nice dialog that asks which partitions
> >> >> you want to use for swap seem to be gone; there's only the window for
> >> >> assigning mount points, and I can't figure out how you tell it to assign
> >> >> a swap partition.
> >> >>
> >> >> The machine's a PTPro 200, 48 megs RAM. Trying to install with a 1.9gig
> >> >> /, a 1.9gig /usr/local, and three 89-meg swap partitions. This doesn't
> >> >> seem to be out of the realm of what the installer should be able to do;
> >> >> I've done far more unusual installs before. Anyone have any ideas? Have I
> >> >> overlooked something, perhaps? Thanks!
> >> >>
> >> >> -Beecher Greenman
> >> >> 
> 


Dan

Terra Soft Solutions, Inc.
 email: dburcaw@yellowdoglinux.com
 website: http://www.yellowdoglinux.com/



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
