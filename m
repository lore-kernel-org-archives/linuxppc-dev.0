Message-ID: <35C119252057D511BB9F0003476BF8A208E5B4@freexc01.smartm.com>
From: "Prasad, Siva" <Siva.Prasad@smartm.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: zImage prefixed with 1KB...
Date: Fri, 21 Sep 2001 13:52:40 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

My zImage is prefixed with 1KB (0x400 locations) of data (mostly zeros
expect the first 8 bytes and few in the middle). And after that comes the
arch/ppc/bot/head.S related code.

Why is this happening. What is the significance of this. Has it anything to
do with mkprep???

Thanks
-- Siva

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
