Message-ID: <3C4C2EB6.6F3ACADE@midrivers.com>
Date: Mon, 21 Jan 2002 08:07:34 -0700
From: Mark Pilon <mpilon@midrivers.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: KERNELBASE & large memory systems
References: <3C4A96D7.9010501@embeddededge.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've heard that one shouldn't modify the definition of KERNELBASE
as it screws up the MM code;

I'm wondering how people out there are handling designing systems
(and getting linux running) on large pools of memory -- like
1 - 2 Gb or so.

0xc0000000 - 0xFFFFFFFF is 1Gb; has anyone redefined KERNELBASE
lower to allow for more memory in a system?

Mark

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
