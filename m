Message-Id: <l03130300b4c30a486a89@[213.6.51.210]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 6 Feb 2000 12:31:58 +0100
To: linuxppc-dev@lists.linuxppc.org
From: Moritz Thomas <motho@gmx.net>
Subject: bug in kernel header
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi there,

when trying to compile some stuff the other day, I found that there is a
bug in "include/asm-ppc/bitops.h" in linux-2.2.13. It's probably fixed
by now (don't have any newer versions), but I thought it doesn't hurt to
report.

The function "ext2_find_next_zero_bit" uses "cpu_to_le32p" which is a
kernel function. However, "ext2_find_next_zero_bit" is not in
"#ifdef __KERNEL__". I guess the obvious solution would be to do just that.

mo


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
