To: Erik Christiansen <erik@dd.nec.com.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Assembler "Error: unsupported relocation against r0" 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 31 Oct 2002 14:39:59 +1100."
             <20021031033959.GA1806@dd.nec.com.au>
Date: Thu, 31 Oct 2002 09:19:24 +0100
Message-Id: <20021031081929.86C1410158@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20021031033959.GA1806@dd.nec.com.au> you wrote:
>
>    powerpc-linux-as, built according to Penguinppc.org's "Cross
> Development mini-howto for PPC Linux", is giving me stick about the
> simplest assembler statements:
>
> fred.s >>>
>    .text
>    .align 2
>    li          r0,0
>    addi        r0,0,0
> <<<
>
> $ powerpc-linux-as fred.s
> fred.s: Assembler messages:
> fred.s:3: Error: unsupported relocation against r0
> fred.s:4: Error: unsupported relocation against r0

Try this instead:

fred.s >>>
	.text
	.align 2
	li	0,0
	addi	0,0,0
<<<

or #include something like "ppc_asm.tmpl" (in the Linux  kernel  tree
as arch/ppc/kernel/ppc_asm.tmpl)

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I paid too much for it, but its worth it.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
