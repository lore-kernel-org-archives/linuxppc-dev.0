Message-ID: <017b01c075f0$15265b50$bf0102c8@sc.mcel.mot.com>
From: "Rolf Liu" <rolfl@sc.mcel.mot.com>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: separate kernel as code segment and data segment for linux ppc ?
Date: Thu, 4 Jan 2001 09:45:55 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,all,
I am planning to run linux-ppc on ppc823 FADS board.
As all know, the kernel is resided in flash rom, then upon power-on, kernel
is copied to RAM.
I wonder if I can just put data segment to ram and leave code segment to
FLASH, just as uClinux
has done. such method will save some ram space, which makes sense on
embedded solutions.
Can you give me a hint how to realize it ?
Any suggestion is appreciated !

BRs
Rolf Liu


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
