Message-ID: <3D7FD2A3.EC0E0F06@terayon.com>
Date: Wed, 11 Sep 2002 16:32:51 -0700
From: Jim Mar <jmar@terayon.com>
Reply-To: jmar@terayon.com
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: 8260 and HPTE
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I am using 2.4.18 on a proprietary 8260 board. It appears that
CPU_FTR_HPTE_TABLE is not supported for the 8260(603e). Therefore,
MMU_init_hw in ppc_mmu.c returns without patching create_hpte and
flush_hash_page in hashtable.S or allocating hash memory.

However, a Data Access Exception(0x300) eventually calls create_hpte,
trashing my memory.

What am I missing here?

Jim


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
