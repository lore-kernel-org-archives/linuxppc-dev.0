Message-ID: <3676EBC1.518C11F1@den.wantweb.net>
Date: Tue, 15 Dec 1998 16:07:45 -0700
From: Ron Nelson <rnelson@den.wantweb.net>
MIME-Version: 1.0
To: laures@hp1.esiea.fr
CC: Liste LinuXppc/dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: pre-R5 installation
References: <3673C7D1.D0934DC7@mail.esiea.fr>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


G. Laurès wrote:
> 
> Hi everybody, I mail you all cause I have probs about a pre R5 installation...
> 
> The following assumes that I've managed to boot properly the installer,
> including second-stage with the 2nd floppy, and t I tried all of this
> with 2.1.125 from R4 installation @ dev.linuxppc.org and last 2.1.130
> from BenH.
> 
>  First I noticed that DHCP configuration for ftp install doesn't work
> (it's over a motorola cybersurf cable modem), I got a "SIGCAUGHT" or
> whatever when choosing this option, I don't exactly remember.
> 
>  Second, ftp installation doesn't work with fixed IP information either
> : it doesn't get ns information, or can't log into server with the
> correct IP address, it seems that no packets can get out of it. Ping on
> it from another machine (my PBG3 with masquerading software) do work
> though (???????).
> 
>  So I tried an HD install... as said Martin Costabel, I had to put all
> the files on an ext2 partition (fine, I had a 2GB hd lying with R4 on it).
> 
>  Third, server nor workstation types of install work, they get you into
> a loop with SCSI adapters and Macintosh-like partitionned hd stuff and
> then on server/workstation/custom rpm choices.
> 
>  But here begin strong problems : it complains about around 35 rpm
> missing (I guess they are not ready yet, I don't care for now, I would
> add some if only I could compile them...), then installs rpms (I choosed
> very basic install, keeping all default but PPP-dialup), and then I got
> a lot of warning like "execution of XXX script failed". Well, it fails
> for initscripts, egcs, binutils, make, egcs, timeconfig, pam/pamconfig :
> all that type of non-useful things if you see what I mean...
> 
>   Then I got panics during time configuration, just after network conf,
> and I have to make a hard reset here.
> 
>    Of course it doesn't boot, warning for being unable to open an
> initial console and to find init stuff -> kernel panic, you have 180
> seconds to type what's on screen...
> 
>  Of course I redownloaded twice of all these critical rpms, I got the
> same warnings. I'll try a third time tommorrow just to be sure...
> 
>   I hope you'll see in there some obvious mistake I'm to tired to see by
> myself... Thanks to anybody who could help, I'm really stuck here.
> 
>  Gom

I just wanted to chime in and let it be known that I am getting the
exact same problems during install with my Powerbase here.. If anyone
has a alternate install procedure please let me know I would love to be
running the new glibc..

Thanks,
Ron Nelson

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
