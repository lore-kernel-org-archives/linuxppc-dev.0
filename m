Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20020522135954.45659.qmail@web15003.mail.bjs.yahoo.com>
Date: Wed, 22 May 2002 21:59:54 +0800 (CST)
From: =?gb2312?q?Dross=20Zhou?= <zjuzhou@yahoo.com.cn>
Subject: Why can't uncommpress kernel after download s-rec file via tftp?
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,
I just added some config option in make menuconfig,
then make zImage and make s-recorde file.
Then download this file into sdram vai tftp,it just
hang at uncompressing kernel image, and can't boot
kernle.
I use linux2.4.4(from denx.de),MPC850, and HHL2.0's
compiler.
I have ment this questions in many borad.

Thx!

--Dross Zhou


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
