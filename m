Message-ID: <20020604233037.65239.qmail@web11504.mail.yahoo.com>
Date: Tue, 4 Jun 2002 16:30:37 -0700 (PDT)
From: Khai Trinh <kqtrinh@yahoo.com>
Subject: Where is the target filesystem to mount for Ebony?
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I had the kernel image loaded and ran on the IBM Ebony
board. However, regarding the filesystem that it
supposed to mount from the Host, I had arbitrarily
give it a fake fs directory specified in /etc/bootptab
so that during kernel boot it will mount to it and
won't complain.

This is not the real Ebony filesystem, however. So my
question is where exactly in the kernel directory tree
should I mount (or even create a ramdisk) from?

Regards,
--Khai


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
