Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: Marco Schramel <Schramel.Linux@go.bartec.de>
To: "PPC_LINUX" <linuxppc-embedded@lists.linuxppc.org>
Subject: insmod trouble
Date: Tue, 25 May 2004 11:05:11 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200405251105.11689.Schramel.Linux@go.bartec.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

My MPC8270 system works with 2.4.26 (toolchain ELDK), for development i use NFS (opt/eldk/ppc_82xx as rootfs). Now i write  a device driver and have some trouble.
I ve searched the whole list, but i didn't found some helpfully comments.

--------------------------------------------------
bash-2.05b# insmod demodriver.o
demodriver.o: unresolved symbol module_unregister_chrdev
demodriver.o: unresolved symbol register_chrdev
demodriver.o: unresolved symbol led_init
demodriver.o: unresolved symbol printf
demodriver.o: unresolved symbol printk
------------------------------------------------

What is the reason for this messages ??
I have enabled module support in my kernel.

Thanks in advance

Marco



---------
Marco Schramel
R&D
Bartec GmbH
Schulstr. 30
94239 Gotteszell, Germany
www.bartec.de
Marco.Schramel@go.bartec.de
Phone:  +49 (0)9929/301332
Fax:    +49 (0)9929/301112


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
