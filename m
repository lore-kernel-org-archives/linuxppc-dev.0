Message-ID: <3E420C30.D22A30C4@innomedia.soft.net>
Date: Thu, 06 Feb 2003 12:48:08 +0530
From: Anand Franklin J <franklin@innomedia.soft.net>
MIME-Version: 1.0
To: ppc_embedded_maillist <linuxppc-embedded@lists.linuxppc.org>
Subject: clarification to _GLOBAL declaration in processor.h!!!
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
        I am compiling a asembler code but it gives the following error,
using the asembler (MVL ppc_405-as)

ppc_call.s:4000: Error: Unrecognized opcode:
`_global(powerpcMfhsmc1_data)'
ppc_call.s:4017: Error: Unrecognized opcode: `_global(setgpio_bit)'
ppc_call.s:4084: Error: Unrecognized opcode: `_global(np_compare_swap)'

how to solve this problem.
thanking you.
franklin.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
