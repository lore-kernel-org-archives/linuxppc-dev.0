Message-ID: <3C237239.22876237@c-s.fr>
Date: Fri, 21 Dec 2001 18:32:41 +0100
From: "LEROY Christophe" <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Kernel BOOT (kernel 2.4.16)
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I'm trying to boot a 2.4.16 linux kernel on a MPC860 based board,
and it hangs up early in
MMU_init().....m8xx_map_io()....io_block_mapping(IMAP_ADDR,...).....mem_pieces_find()....

because it cannot find any piece for IMAP_ADDR,   as set_phys_avail()
only put map for RAM in phys_avail table.

Can someone help me ?

Thanks

C.Leroy

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
