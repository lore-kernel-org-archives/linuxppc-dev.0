Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20040826100827.78542.qmail@web15603.mail.cnb.yahoo.com>
Date: Thu, 26 Aug 2004 18:08:27 +0800 (CST)
From: Song Sam <samlinuxppc@yahoo.com.cn>
Subject: Cramfs Limitations
To: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040816162120.6403FC109F@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

When creating CRAMFS filesystems on my custom 8xx
board based on MTD,application stopped with the
following message:

Error in Step 7: Cannot load shared resource!

INIT: can't open(/etc/ioctl.save,O_WRONLY):Permission
denied!

What's on earth with it?Could 2_4_devel or 2.6 fix it?

Thanks in advance!

Sam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
