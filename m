Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3CD2255B.330FA4E4@ardistech.com>
Date: Fri, 03 May 2002 07:51:23 +0200
From: "bart@ardistech.com" <bart@ardistech.com>
Reply-To: bart@ardistech.com
MIME-Version: 1.0
To: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Cc: dmalek@jlc.net
Subject: MP8xx: not initialized CPM RAM crash
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I found in ./drivers/i2c/i2c-rpx.c in rpx_iic_init the structure member
ii->iic_rpbase != 0. Very likely because ppcboot uses this area as initial
stack. This causes the kernel to get a machine check during i2c init. Should
the CPM RAM not be zero'd somewhere during kernel boot?

Regards,
	Bart

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
