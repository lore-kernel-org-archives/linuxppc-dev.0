Message-ID: <007801c45374$2c53fcf0$2700000a@jmartin>
From: "jmartin" <jmartin@prodys.net>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: consistent_alloc question
Date: Wed, 16 Jun 2004 09:33:09 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


   Hi:

      i'm working on a embedded platform based on mbx860. This board uses an
   mpc860T,no pci available. Since i update to montavista 3.1 i have
 problems
   in fec. Kernel don't boot, fec gives a transfer error ack signal, at
fec.c
   line 1737. debugging kernel, i can't access to cbd_base. I suppose memory
   map is  wrong. No pci bus available. consistent_alloc seems to get a free
   page, mark uncacheable, remove it from free_pages list, and map it.

    what memory zone is used by consistent_alloc? cbd_base seems contain a
   virtual address mapped to a physical address.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
