Message-ID: <19991030030256.17478.rocketmail@web308.mail.yahoo.com>
Date: Fri, 29 Oct 1999 20:02:56 -0700 (PDT)
From: Brian Kuschak <bkuschak@yahoo.com>
Subject: Re: Kernel Math Emulation vs. -msoft-float and -nfp
To: wung_y@263.net, Grant Erickson <grant@lcse.umn.edu>
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



> i cannot find any math-emu lib for ppc. does
> linuxppc have one? there is 
> a dir called math-emu in the arch/i386 and
> arch/sparc64 while arch/ppc
> not.
> 

There is a math emulator in the 2.3.18 kernel.  I'm
using it on an 823 with some success.  I'm not sure if
the kernel does any FP ops, but the bash shell
definitely does.  These instructions generate
exceptions that the math-emu catches.

Hope that helps,
-Brian


=====


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
