Date: Thu, 16 Aug 2001 17:55:11 +0200
From: Jure Menart <jure@kom.org>
To: linuxppc dev <linuxppc-dev@lists.linuxppc.org>
Subject: linux-2.4 & 405gp & other stuff
Message-ID: <20010816175511.A1012@hannanges.teden-mladih.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello everyone,
I've tried to compile linux-2.4 kernel (I tried with sources from
kernel.org and with sources from denx.de) but it wasn't successful.
Error output was:
------------------------------------------------------------------------
    {standard input}: Assembler messages:
    {standard input}:85: Error: unsupported relocation type
    {standard input}:86: Error: unsupported relocation type
    {standard input}:113: Error: unsupported relocation type
    {standard input}:130: Error: unsupported relocation type
    {standard input}:147: Error: unsupported relocation type
    {standard input}:151: Error: unsupported relocation type
    {standard input}:66: Error: unsupported relocation type
    make[1]: *** [ppc4xx_pic.o] Error 1
    make[1]: Leaving directory
    `/usr/src/linux-2.4.4-2001-05-12/arch/ppc/kernel'
    make: *** [_dir_arch/ppc/kernel] Error 2
------------------------------------------------------------------------

Kernel was configured for PPC 4xx, Oak Machine type - it had included
only parallel port, serial console, initrd, ide... really 'bare' kernel.

As I could see problem lies in {srcdir}/arch/ppc/kernel/ppc4xx_pic.c (as
obvious :-) - in functions to initialize 405gp interrupt stuff - is
this part (ppc405_uic_enable(), ppc405_uic_disable(),...) implemented
anywhere? I didn't find them in any new sources...
Is there any other way to compile kernel for 405gp? I've got custom made
board, not any of evaluation boards.

Next question I have is: What exactly is 'Machine type' in Platform
support in kernel configuration? What are 'oak' and 'walnut'? Is this
like description of board?

One more question (yeah I know - I'm bugging - sorry :-)
IBM 405gp has included ethernet controller - are there any drivers for
it?

Thank you in advance...

Regards, Jure


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
