Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <000b01c24a85$0596a620$cc00a8c0@ycigrnd.ycig.com>
From: "leeyang" <leeyang@ycig.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: linux booting
Date: Fri, 23 Aug 2002 17:11:08 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi,all!
These days I am trying to upgrade kernel from
2.2.14 to 2.4.20-pre2 in my 860T custom board.

The old 2.2.14 kernel and ppcboot do work,and
I add some custom board file to the 2.4.20-pre2
soure tree from linuxppc_2_4_devel,and comile
it successfully.(no any warn or error in my modify)

When I "bootm 0x10000"in ppcboot,it runs to
"Transferring control to linux kernel",then hangs
there,and I see nothing in the console.:(

In the PPCBoot guide(FAQ section),it mentioned
2 possible causes,wrong bdinfo and clocks_in_mhz
I do check it and feel nothing wrong,however
nothing yet.

I have a BDI2000,but I think I should debug the bootm
part of ppcboot,however someone says it is quite
difficult to do so( at least for me).
so I am seeking errors in blind.

hope some light!

leeyang

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
