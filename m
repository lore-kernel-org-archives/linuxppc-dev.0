From: nbasker@india.tejasnetworks.com
Message-ID: <1065623430.3f841f86ab2cb@pop-mail.india.tejasnetworks.com>
Date: Wed, 08 Oct 2003 20:00:30 +0530
To: linuxppc-embedded@lists.linuxppc.org
Subject: question on using correct in/out functions
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi:

We use a mpc860t based board (2.4.20 kernel) and the addresses
beyond 0xf0000000 are io-remapped. In driver space, to access memory
mapped devices beyond this address i have some simple routines like
in8/in16/in32 and out8/out16/out32 which basically use val = *addr or
*addr = val kind of access.

I would like to use routines from asm-ppc/io.h file. But there are
atleast two choices like insl/outsl or in_le32/out_le32. My problem
is that I do not understand them well to use the correct one. I have searched
for documents in the documentation directory and google search but could
not find anything useful.

It would be helpful if I can get some pointers on how to use functions
in io.h file

Thansk for your time,
Nicholas.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
