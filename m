Message-ID: <37B31A3B.8532D794@wanadoo.fr>
Date: Thu, 12 Aug 1999 21:02:19 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: toa@pop.agri.ch
CC: Linux-User <linuxppc-user@lists.linuxppc.org>,
        Linux-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: xhfs & MacOS standard disks corruption
References: <37B30E49.844CA5A8@pop.agri.ch>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Andreas Tobler wrote:
> 
> Hi,
> 
> has anybody made similar experiences with xhfs (from hfsutils-3.2-1b):
> 
> Under MacOs 8.6 cleaned the disk with DiskFirstAid 8.5.2.

hfsutils-3.2-1b is pretty old, maybe from the times when hfs support was
indeed unsafe (March 1998 or so). Are you still using R4? Even then, you
could get a newer hfsutils*.src.rpm and compile it; for ex. from the
contrib directory on ftp.linuxppc.org.

> Boot into Linux, startx, xhfs & open the cleaned partition, transfer a
> file, in my case 9MB, to the mounted partition.
> Afterwards closed the xhfs shut the machine down to reboot into MacOS.
> 
> A check on this partition gives me an error in the catalog tree.
> Ok, doing a repair to it works. But as it happened to me doing that
> several times without checking/reparing the partition I got an
> unreparable partition which I had to erase.
> This is done with 2.2.10 & 2.2.11.
> Question: is xhfs bad? or is there something uggly with hfs support?

MacOS 8.6 + Linux 2.2.10, and then hfsutils-3.2-1b: Somewhat
incongruous.

Disclaimer: Your problem could be something else entirely, of course.

--
Martin

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
