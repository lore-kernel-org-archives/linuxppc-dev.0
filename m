Message-ID: <20000314141913.16859.qmail@web219.mail.yahoo.com>
Date: Tue, 14 Mar 2000 06:19:13 -0800 (PST)
From: Sebastien Articlaux <sebastien_articlaux@yahoo.com>
Subject: Hi!
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Wolfgang,

My last e-mails on the mailing list wasn't very
constructive...I'm agree!
So,I've made some research to inform me on the process
of creating a ramdisk.
I've learned a lot of things and now I know the good
questions to ask!

Ok, tell me if I'm wrong!
Normally there is two ramdisk, the init ramdisk and an
other,bigger wich contain the complete system.
and this is linuxrc in the initramdisk wich mount the
real ramdisk, right?
But for us,we just use the initramdisk "as ramdisk"...
It's a minimal file system but to begin it's ok,
right?
So now I'm trying to create a good initramdisk.
I've put the patch for SASH in source, but I must have
to recompile SASH (that's what I understand when I
look into your CDK files)
Where can I found the source of SASH if I must
recompile it?
Then do I must put it in /bin/sash in my initrd and
make a link?
ln -s sash sh  to have /bin/sh -> sash  ?
And need I have to create a linuxrc if I have just the
initrd? if yes, what must I put in it because I don't
understand.

Thanks you for your help

Sébastien ARTICLAUX


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
