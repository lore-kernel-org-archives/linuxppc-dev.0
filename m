Message-ID: <35C119252057D511BB9F0003476BF8A208E5C2@freexc01.smartm.com>
From: "Prasad, Siva" <Siva.Prasad@smartm.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: mtmsr...
Date: Tue, 25 Sep 2001 18:53:19 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

My zImage hangs immediately after executing the 'mtmsr' instruction in the
arch/ppc/boot/head.S file.

li    r3, 0
mtmsr r3
isync

This is in the very beginning of the zImage, where it uncompresses the
actual image. Can some one help me out.

Thanks in advance.
-- Siva

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
