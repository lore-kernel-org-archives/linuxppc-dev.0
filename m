From: ghannon@cspi.com
To: linuxppc-dev@lists.linuxppc.org
Message-ID: <85256B65.0078DAC9.00@pine.cspi.com>
Date: Tue, 19 Feb 2002 17:19:50 -0500
Subject: SCSI error on MVME5100
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am running an MVME5100 board using a
2.4.11 kernel, and keep getting the following error with the
SCSI driver.
It will run for a while before the error occurs, but once it starts it just
keeps posting this error.

sym53c895a-0:0: ERROR (a0:0) (0-a0-0) (0/f) @ (script a14:c0040b5d).
sym53c895a-0: script cmd = 00000174
sym53c895a-0: regdump: da 10 c0 0f 47 00 00 0e 72 08 80 a8 80 00 08 08 00
e0 b7
03 0a 00 00 00.

Has anyone seen this before?

Also,  I tried building a 2.4.18-pre9 kernel, and I see that
CONFIG_MVME5100
is no longer in the source at all.  Did it get merged in at some point?

I can post more info if this is not enough to go on.

Thanks,
Gary Hannon
CSPI


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
