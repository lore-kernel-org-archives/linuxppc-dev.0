Message-Id: <200008032302.TAA29224@mal-ach.watson.ibm.com>
To: Thomas Graichen <graichen@innominate.de>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: shifts on 64bit ints 
In-Reply-To: Message from Thomas Graichen <news-innominate.list.linux.ppc.dev@innominate.de>
   of "03 Aug 2000 22:38:06 GMT." <news2mail-8mcs8e$kdj$2@mate.bln.innominate.de>
Date: Thu, 03 Aug 2000 19:02:31 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	First, I would suggest that you use a printf format like "%08x"
for better legibility.

	Second, I tried your example with gcc-2.95.2 on PowerPC AIX
gcc-2.95.2 on PowrePC Linux, and a recent development snapshot of GCC with
various optimization levels (you did not specify what options you used to
compile the testcase) and I consistently saw the following output:

Mask 29 is 0x0000000020000000 - 0xffffffffdfffffff
Mask 30 is 0x0000000040000000 - 0xffffffffbfffffff
Mask 31 is 0x0000000080000000 - 0xffffffff7fffffff
Mask 32 is 0x0000000100000000 - 0xfffffffeffffffff
Mask 33 is 0x0000000200000000 - 0xfffffffdffffffff
Mask 34 is 0x0000000400000000 - 0xfffffffbffffffff

	You appear to have a problem, but it is local to your system
(could be toolchain or C library as well).

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
