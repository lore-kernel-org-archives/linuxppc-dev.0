Message-ID: <001701c0c41b$f1f4fea0$6f0fa8c0@DWaves.com>
From: "Ami Levi" <AmiL@kswaves.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: kernel MMU initialization problems when extemding physical memory form 8M to 16M
Date: Fri, 13 Apr 2001 15:16:11 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="windows-1255"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

We are running Linux 2.2.13 on our custom embedded MPC850 platform.
We are using ppcboot 0.4.1

With 8M configuration everything runs OK. No problems

When we extend the SDRAM from 8M to 16M the kernel crashes with 'machine
check'
exception that caused by 'turn_on_mmu' routine inside head.S file.
>From ppcboot we can see all memory area, available to read & write.

Do I need to change any additional registers besides OR's & BR's ?
We have also changed the refresh rate to meet the increased memory
configuration.

Any suggestions ?


=============================
Ami Levi
amil@kswaves.com
Embedded platform engineer
K.S.Waves Ltd.
Main Phone: 972 3 6081648
Direct Phone: 972 3 6081671
Fax: 972 3 6081656
=============================


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
