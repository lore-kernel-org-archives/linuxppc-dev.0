Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20040203144648.95218.qmail@web41404.mail.yahoo.com>
Date: Tue, 3 Feb 2004 06:46:48 -0800 (PST)
From: Jeff Stevens <jsteve17@yahoo.com>
Subject: Linux MPC8xx I2C Interface
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am working on a proprietary board which I have
U-Boot and ELDK Linux ported over to.  On the board
there is an I2C bus that first connects to a PCA9556
(I2C Hub Controller at 0x18) & PCA9516 (I2C Octal
Hub).  So I need to be able to talk to the PCA9556 to
set up the hub controller to activate one of the bus
segments on the hub.  I am able to read and write to
all my I2C devices under U-Boot, but not under Linux.
I have tried both compiling, and creating modules of
i2c-core, i2c-dev, and i2c-algo-8xx.  I also patched
the kernel with the i2c patch which also gave me
i2c-proc.  I don't get any errors when I boot with
them compiled into the kernel, or when I insert them
as modules.  However, I don't see any devices.  What
am I doing wrong?  Also, I would rather talk to the
I2C devices directly through the CPM interface, and
not through the dev interface.  Is there a way to do
this?  Is there any good documentation out there?

Thanks in advace,
   Jeff Stevens


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
