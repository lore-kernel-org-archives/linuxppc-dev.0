Message-ID: <4102DF54.9060007@att.net>
Date: Sat, 24 Jul 2004 15:14:44 -0700
From: "DeLaGarza, Robert" <robdlg@att.net>
MIME-Version: 1.0
To: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: MPC8245 Error No. 26
References: <KCEOLLHGFJIAFNAMGACHMEMODPAA.k@kcomputing.com> <000f01c47172$591008d0$0301a8c0@chuck2>
In-Reply-To: <000f01c47172$591008d0$0301a8c0@chuck2>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


With regard to "Error No. 26" (quoted below), has any work been done in
the kernel or serial drivers to compensate for this error?

I've observed problems only when both UARTs were enabled, so I suppose
one solution is to enable only one UART.



Error No. 26: Concurrent writes occur to the UART registers when
UAFR[0] is set

Detailed Description:
The UART Alternate Function Register (UAFR) enables software to write
concurrently to both UART1 and UART2 registers with the same write
operation. However, this action occurs when the UARTs are individually
written to, but in addition, concurrent writes to the UART registers
occur as a result of writing to other EUMBAR registers, including the
error injection registers, when UAFR[0] is set.

Projected Impact:
Concurrent writes occur to the UART registers when UAFR(0) is set and
EUMBAR registers are written to.

Work Arounds:
Set UAFR(0) only for concurrent writes to UART registers. Clear this bit
immediately afterwards.

Projected Solution:
No plans to fix.

http://www.freescale.com/files/32bit/doc/errata/MPC8245CE.pdf


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
