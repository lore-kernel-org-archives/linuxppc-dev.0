Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <v04104400b2e2791a2ac6@[152.173.248.113]>
In-Reply-To: <19990205164543.000681@mail.mipsys.com>
Date: Sat, 6 Feb 1999 15:03:31 -0800
To: BenH <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org,
        linuxppc-user@lists.linuxppc.org, linux-pmac@samba.anu.edu.au
From: "Sandor W. Sklar" <ssklar@stanford.edu>
Subject: Re: BootX test 1.0.2b1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On my PowerBook G3 Series 250/13.3, your new BootX works *perfectly*,
adding a feature that I had been hoping and praying for -- alias resolution.

I now have a folder of vmlinuxes, named with the build version and date.  I
now can pick one, make an alias to it named "vmlinux", and put it in the
system folder, and it works!  Thank you so much!

It also seemed to have no problem passing "video=atyfb:vmode:14,cmode:32"
in the 'additional kernel arguments' line.

One other added benefit I noticed is an increase in speed.  With the 1.0.1
BootX app, it would take between 30-45 seconds after pressing the "linux"
button for anything to happen.  This version of the BootX app started
working 5-10 seconds after pressing the "linux" button.

Thanks again, and it worked great for me!

--Sandy

PS:  Another feature that would be nice (if not too difficult) would be the
ability to fire off an applescript that would make sure that the "Sound
Monitoring" was set to Expansion Bay in the Monitors & Sound control panel
before booting into Linux.  But I don't think that this is too important.
Thanks again, --Sandy

At 4:45 p  +0100 2/5/99, BenH wrote:
>At this address:
>
><ftp://ftp.linuxppc.org/development/users/benh/BootX_1.0.2b1.sit>
>
>Is a test version of BootX. It contains some minor changes that I want to
>be tested before it becomes 1.0.2 final. Please tell me if it breaks
>something on your config that used to work with 1.0.1. Please also tell
>me if there is a difference in behaviour with 1.0.1.
>
>Changes:
>
> - MacOS video drivers are closed before switching to linux
> - Supports Finder aliases for the kernel and ramdisk
> - Slight changes to the infos passed to the kernel, will do no harm for
>now and will improve compatibility once the appropriate kernel patch is
>released.
>
>
>--
>           E-Mail: <mailto:bh40@calva.net>
>BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>
>
>
>
>
>
>[[ This message was sent via the linuxppc-user mailing list. Replies are ]]
>[[ not forced back to the list, so be sure to  Cc linuxppc-user  if your ]]
>[[ reply is of general interest. To unsubscribe from linuxppc-user, send ]]
>[[ the message 'unsubscribe' to linuxppc-user-request@lists.linuxppc.org ]]



-----------------------------------------------------------
     Sandor W. Sklar
     Project Liaison, ITSS/OSS
     Stanford University
     Polya Hall, Room 256   MC: 4136
     Stanford, CA 94305-4136
     Tel:  (650) 723-0512
-----------------------------------------------------------

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
