Date: Wed, 24 Oct 2001 23:08:47 -0500
Subject: Re: 7025 F40 CHRP IBM
From: Hollis Blanchard <hollis-lists@austin.rr.com>
To: Cloves Ferreira Jr <cfj@cefetgo.br>,
	<linuxppc-dev@lists.linuxppc.org>
Message-ID: <B7FCFA7F.134E%hollis-lists@austin.rr.com>
In-Reply-To: <3BD2E3A5.6EFA4AF8@cefetgo.br>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


on 21/10/01 10:03 AM, Cloves Ferreira Jr at cfj@cefetgo.br wrote:
>
> I am trying to produce a zImage that can boot on a 7025 F40 CHRP IBM
> workstation using linux kernel 2.4.3 with 110 tarball patches.
> I debuged some kernel code and found an abnormal execution at
> arch/ppc/kernel/i8259.c in i8259_init function. This function is called
> by arch/ppc/kernel/chrp_setup.c in chrp_init_IRQ function.
>
> When the start init sequence is executed a MachineCheckException is
> generated printing a text message like: OUT to bad port 21 at...

This message comes from arch/ppc/kernel/traps.c MachineCheckException()

Do you know if you have an 8259 in that machine? Unless your memory map is
very screwy (but I think it should be handled fine by the current PReP
code), there doesn't seem to be anything at 0x20 (system IO)...

-Hollis


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
