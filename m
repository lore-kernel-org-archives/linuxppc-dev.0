Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3D062232.3010003@cray.com>
Date: Tue, 11 Jun 2002 11:15:46 -0500
From: David Updegraff <dave@cray.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: mem= flag behaviour
References: <20020611133650.87793.qmail@web15003.mail.bjs.yahoo.com>
Content-Type: text/plain; charset=GB2312
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi.

I'm trying to keep a small trace buffer over re-boots
of linux from ppcboot, so give a mem=31M flag to linux
kernel.  Yet by the time linux is up, it has overwritten
that memory anyway..   PPCBOOT is properly leaving it
be (with PRAM feature) and correct arg. goes to kernel..

After 'reboot' from linux, the memory contents of
the last meg are still valid (in ppcboot) but by the time linux
is back up, the region has been trashed.  Why?

Help, please.  How to prevent linux from talking to
that memory region during bootup?

--
David Updegraff / dave@cray.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
