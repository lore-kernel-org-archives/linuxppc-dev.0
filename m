Message-Id: <s06bf008.073@mail.frequentis.com>
Date: Thu, 01 Apr 2004 10:35:11 +0200
From: "Gerhard TAEUBL" <Gerhard.TAEUBL@frequentis.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: pci mbx860
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi!

According to
http://lists.linuxppc.org/linuxppc-embedded/200312/msg00003.html

I try to get the qspan work on our custom board, and found the patch. It works but in my kernel version (eldk 3.0 kernel 2.4.24) the m8xx_setup_pci_ptrs function is called before bootmem is initialised (in arch/ppc/kernel/m8xx_setup.c), so first the kernel crashes after decompressing the kernel.
So I moved the function call from the function
platform_init to m8xx_setup_arch, then it works.
Is that correct or exists a better point where to call this function?

kr
Gerhard


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
