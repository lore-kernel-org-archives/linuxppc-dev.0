Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Mon, 25 Nov 2002 18:59:56 +0800
From: caixupeng <edmoon@huawei.com>
Subject: ppcboot, linux , hang  at the last step
To: linuxppc-embedded@lists.linuxppc.org
Message-id: <000d01c29471$ca5b94d0$92690b0a@DBKQW41X>
MIME-version: 1.0
Content-type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear all,

When I boot a linux image use "bootm ffa00000 ffb00000"
the linux hang at the last step:

VFS: Cannot open root device "" or 16:01
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 16:01

I have set the "bootargs=root=/dev/ram"

what's wrong ?

Is my linux kernel's erro or ppcboot's problem?
Does ppcboot send the bootargs to linux kernel correctly?

Where can set the boot params in the linux source code ?
I want to set the params in code to force it correctly.

I use linux-2.4-develop-rc1 which download from bitkeeper.

my board is Ebony.

thanks!

                    edmoon

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
