Date: Wed, 03 Feb 1999 00:10:04 -0500
From: Beecher Greenman <rbg6038@ritvax.isc.rit.edu>
Subject: Re: EGCS upgrade?
To: linuxppc-dev@lists.linuxppc.org
Message-id: <01J7ACHVG2R69PLYYR@ritvax.isc.rit.edu>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


OK, an update. I managed to find the patched EGCS upgrade RPM's from 
gary's section of the linuxppc.org ftp site. I installed them (and most 
of the other stuff in there) and it all works fine.

Problem is, I still can't find any libstdc++ anywhere on my hard drive. 
Lots of symlinks to it, to be sure (actually they're all looking for 
libstdc++.so.2.8.0) but no library itself. Any clues on where to find it? 
Might I be able to compile it out of the egcs-1.1.1 sources without any 
trouble (my guess is no)? Not being able to use Netscape is beginning to 
get annoying...

On an unrelated topic, I've noticed that about half the time I try to 
shut down, I get a message saying "/ is busy" when the system tries to 
umnount it. This, of course, makes fsck VERY unhappy when I try to 
reboot, and I have to sit and listen to it whine (it only ever finds one 
error; a single deleted inode with zero dtime, and it's always the same 
one, which is fine when rebooting if the unmount succeeded before). Any 
idea on what might be causing that one? Thanks!

LinuxPPC R4 (kernel 2.2.0pre2) on a G3/300 Desktop, 128 megs ram, 128 
megs swap, 2gig root.

-Beecher Greenman

>I tried upgrading to EGCS 1.0.3 using the RPM on biggi.linuxppc.org. It 
>didn't work, so I tried uninstalling it and reinstalling with the 
>original RPM's, but that appears to have fried my libstdc++, which among 
>other things keeps Netscape from working. I'm trying to upgrade EGCS as 
>high as I can, since I want to try running Kernel 2.2.1 (anyone have a 
>prebuilt kernel out there, by any chance?)
>
>Compiiling from the Cygnus sources for 1.1.1 didn't seem to work; there 
>were more than a few errors when I tried (and that's really a shame; I 
>was reading that 750 support was just added and I wanted to try that one 
>out).
>
>Anyway, what's the best way to upgrade my EGCS installation past the 1.0 
>on biggi? For that matter, where can I find another copy of libstdc++; I 
>didn't see any RPM's on biggi that might have it. Thanks!
>
>-Beecher Greenman

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
