Message-ID: <3BDF0E29.8FFB2C7@mvista.com>
Date: Tue, 30 Oct 2001 12:31:37 -0800
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Jim Duey <jduey@ccc-dcs.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PPC 405 Register Model
References: <3BD813CE000007B2@charlotte.ccc-dcs.com> (added by charlotte.ccc-dcs.com)
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jim Duey wrote:
>
> I'm needing to do some inline assembly for the Walnut board running MVista's
> Hard Hat Linux and I'm concerned about clobbering registers.  Can someone
> point me to docs or source code that describes the register usage of HHL on
> the 405GP?

If you use variable names instead of hard coding register numbers you
don't have to worry about clobbering registers.  For example, look
at include/asm-ppc/atomic.h and you can find documentation of inline
assembly at:

  http://gcc.gnu.org/onlinedocs/gcc-2.95.2/gcc_4.html#SEC93

-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
