Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20031118071829.43116.qmail@web40301.mail.yahoo.com>
Date: Mon, 17 Nov 2003 23:18:29 -0800 (PST)
From: Miku Jha <jha_miku@yahoo.com>
Subject: ppc440 and i2c
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I am running ppc440 with linux kernel version 2.4

If I reboot the ppc440 in middle of a read transaction
from a slave say( at the 3rd clock pulse for example)
then somehow ppc440 is hung.

Basically when it comes up it sees that data line
held low.
How does the powerpc deal with this situation.?

>From the i2c bus trace it looks like in this
situation ppc440 keeps issuing the clock pulses
until the data line SDL is released by the slave
but following that the SCL line is held low
by ppc440 and is never released or set to IDLE?

Is this the expected behaviour if the SDL is held
low when the ppc440 comes up.
Is there anyway I can fix this in the ppcboot code.

Please let me know.
Any help appreciated.

Thanks a bunch


=====
mailto:jha_miku@yahoo.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
