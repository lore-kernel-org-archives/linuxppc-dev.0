To: linuxppc-dev@lists.linuxppc.org
Subject: tas: I2C byte write failed
From: Andreas Schwab <schwab@suse.de>
Date: Sat, 09 Aug 2003 10:25:43 +0200
Message-ID: <m3he4r8cfs.fsf@whitebox.as.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Whenever my iBook wakes up I get the message "tas: I2C byte write
failed" and sound remains silent.  This is with 2.4.21-ben2 (TAS3004
driver V 0.3), but happens with previous versions as well.  Could this
be a problem of wrong reinitialisation order during wakeup (both
dmasound and i2c are compiled as module)?  Resetting the volume makes
sound work again.

Andreas.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
