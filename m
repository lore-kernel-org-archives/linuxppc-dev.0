Date: Fri, 7 Jan 2000 21:35:29 +0000
From: "Robin O'Leary" <robin@equiinet.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: linux-2.3.37
Message-ID: <20000107213528.A29581@mail.ro.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I just tried building the latest 2.3.37 from ftp.kernel.org for the 8xx.
It failed with the error:
    arch/ppc/8xx_io/8xx_io.a: In function `m8xx_cpm_reset':
    arch/ppc/8xx_io/8xx_io.a(.text+0x54): undefined reference to `find_pte'

There is no inline find_pte() in include/asm-ppc/pgtable.h as there was
before, yet arch/ppc/8xx_io/commproc.c (and enet.c and fec.c) still try
to use this function.  Where has it gone?

What is the currently recommended kernel for 860-based development and
where can I get it?

Robin O'Leary.
-- 
email: robin@equiinet.com  Equiinet Ltd., Innovation Centre, Singleton Park,
Tel.:  +44 1792 540008     Swansea  SA2 8PP, Wales, U.K.  51.6101N 3.9831W

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
