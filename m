Message-ID: <3D8A1265.D0CC5D33@selta.it>
Date: Thu, 19 Sep 2002 17:07:33 -0100
From: stefania magistrali <s.magistrali@selta.it>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: loading modules
Content-Type: text/plain; charset=iso-8859-2
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all!
I am working with a PowerPC 860T based board.
I have a problem with loading modules: I made:

make dep make clean make zImage  make modules  and make modules_install

to create my kernel and modules  , but when I try to load the module
hdlc.o with insmod, I have a segmentation fault. I am using busybox
version 0.60.3  and linux version 2.4.19pre6. Here I send the last part
of the strace sequence of the command "insmod  hdlc"
Can anyone help me?
Thanks very much in advance!
Stefania

query_module(NULL, 0, NULL, 0)          = 0
query_module(NULL, QM_MODULES, { /* 0 entries */ }, 0) = 0
mmap(NULL, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x30033000
query_module(NULL, QM_SYMBOLS, 0x30032e08, 16384, 21866) = -1 ENOSPC (No
space left on device)
mmap(NULL, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x30037000
query_module(NULL, QM_SYMBOLS, { /* 961 entries */ }, 961) = 0
--- SIGSEGV (Segmentation fault) ---
+++ killed by SIGSEGV +++


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
