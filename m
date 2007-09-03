Return-Path: <pradyumna.sampath@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.177])
	by ozlabs.org (Postfix) with ESMTP id AA20BDDE47
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  3 Sep 2007 21:23:44 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so5526507pyi
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 03 Sep 2007 04:23:43 -0700 (PDT)
Message-ID: <f87351060709030423t1ac14f3cqd0cd224ba7dba9c5@mail.gmail.com>
Date: Mon, 3 Sep 2007 16:53:43 +0530
From: "Pradyumna Sampath" <pradyumna.sampath@gmail.com>
To: linux-rt-users@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: rc4-rt1: powerpc compile errors
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi everyone,

Here are some compile errors from the latest -rt patchset for powerpc
(mpc5200).

arch/powerpc/kernel/entry_32.S: Assembler messages:
arch/powerpc/kernel/entry_32.S:231: Error: operand out of range
(0x00023d87 is not between 0x00000000 and 0x0000ffff)
arch/powerpc/kernel/entry_32.S:644: Error: operand out of range
(0x00022006 is not between 0x00000000 and 0x0000ffff)
arch/powerpc/kernel/entry_32.S:866: Error: operand out of range
(0x00020004 is not between 0x00000000 and 0x0000ffff)
arch/powerpc/kernel/entry_32.S:880: Error: operand out of range
(0x00020004 is not between 0x00000000 and 0x0000ffff)

Im not sure whether this is the right thing to do but we got around
this by replacing the linux/include/asm-powerpc/thread_info.h with an
older version of the same file from 2.6.21-rt3.

regards
/prady

-- 
htp://prady.livejournal.com
