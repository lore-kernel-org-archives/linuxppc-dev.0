Message-ID: <39EEECA5.459D0C93@agelectronics.co.uk>
Date: Thu, 19 Oct 2000 13:44:21 +0100
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: ppc_ide_md.insw
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Do ppc_ide_md.insw and .outsw actually do anything in recent 2.2
kernels? My grepping has left me unclear.

I need to implement a driver for a compact flash interface which can't
take 16-bit cycles. Do I need to invent my own mechanism to replace the
insw and outsw operations in drivers/block/ide.c?

- Adrian Cox, AG Electronics

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
