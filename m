Message-ID: <37B30E49.844CA5A8@pop.agri.ch>
Date: Thu, 12 Aug 1999 20:11:24 +0200
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Linux-User <linuxppc-user@lists.linuxppc.org>,
        Linux-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: xhfs & MacOS standard disks corruption
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
 
has anybody made similar experiences with xhfs (from hfsutils-3.2-1b):

Under MacOs 8.6 cleaned the disk with DiskFirstAid 8.5.2. 
Boot into Linux, startx, xhfs & open the cleaned partition, transfer a
file, in my case 9MB, to the mounted partition.
Afterwards closed the xhfs shut the machine down to reboot into MacOS.

A check on this partition gives me an error in the catalog tree. 
Ok, doing a repair to it works. But as it happened to me doing that
several times without checking/reparing the partition I got an
unreparable partition which I had to erase.
This is done with 2.2.10 & 2.2.11.
Question: is xhfs bad? or is there something uggly with hfs support?

Thanks for any responses

Andreas


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
