Message-ID: <D769D33A5A2FBD4381E1F6030D28DBFA01029C92@hq-ex-6>
From: Brian Kuschak <bkuschak@brocade.com>
To: "'Brad Parker'" <brad@parker.boston.ma.us>,
	Brian Kuschak <bkuschak@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: initrd in 2.4.19
Date: Thu, 2 May 2002 10:13:30 -0700 
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I want to use pivot_root, so I don't use the special /linuxrc running
> code.  Instead I use "init=/linuxrc" as part of the command line.  If
> you do this your first script should work fine (pivot follwed by
> chroot).  But to be honest, I don't chroot.  I don't think it's
> necessary.

Using init=/linuxrc allows my first script to work.

However, it's a bit restrictive:  if I want to override the usual boot
sequence and get the kernel to mount the real root and drop into a shell I
can't use this method.  With the 'old-style' script, I can set
"init=/bin/bash".  These get applied AFTER /linuxrc terminates.  If I use
your method, I can't do that.

I realized yesterday that my second script works if I unmount /dev/hda2
before exiting /linuxrc.

Thanks,
Brian

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
