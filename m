Message-ID: <3859E974.ED7F394D@pop.agri.ch>
Date: Fri, 17 Dec 1999 08:42:44 +0100
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Dev-Linux <linuxppc-dev@lists.linuxppc.org>
Subject: linux-pmac-devel-16.12 Wallstreet troubles
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
yesterday I rsynced the linux-pmac-devel from linuxcare. I used the make
xconfig to comment out the ramdisk. Normally I do make pmac_config, make
menuconfig.

The compile failed somewhere in arcg/ppc/mm/init.c, a few things were
not declared. A grep showed me where they are and so I included
pgalloc.h in init.c. Now the build went ok.
Booting this 2.3.29 I got a divided screen. I had this before too on a
2.3.25-26. But there it was a problem with the kernel args. I didn't
separate the video args properly, so it must have been a mess in
interpreting the args.

Now I think it must be something different. 
Has anybody made the same experience? Separated screen on Wallstreet
with big vertical stripes on the left screen area?

My kernel args in Bootx are: video=atyfb:vmode:14,cmode:32,mclk:67  
I tried different mclk's. Under 2.2.1X it works perfect.

Thanks,

Andreas
-- 
| Andreas Tobler				
| CH-8004 Zuerich 							
| E-Mail: andreas.tobler@alcatel.ch	| a.tobler@schweiz.ch
-----------------------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
