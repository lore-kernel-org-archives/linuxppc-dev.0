From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: linuxppc-dev@lists.linuxppc.org, Paul Mackerras <paulus@linuxcare.com>
Subject: Error compiling Paul's latest stable kernel : missing buffer_lowprio in include/linux/fs.h
Date: Wed, 17 Nov 1999 22:43:17 -0500
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <99111722474100.07507@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I seem to be getting the following error when building Paul's latest stable
kernel rsynced just this morning from Paul's linuxcare.com.au site.

The error message I get is that buffer_lowprio is undefined.  Unfortunately it
is used in drivers/block/md.c, raid5.c, and ll_rw_blk.c).  I looked in my old
2.2.13 kernel source tree and it was previously defined in include/linux/fs.h
but in the latest stable kernel its definitiion has been removed.

Any ideas here would be greatly appreciated.

Thanks,

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
