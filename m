Return-Path: <matej.kupljen@ultra.si>
Received: from deliver-1.mx.triera.net (deliver-1.mx.triera.net [213.161.0.31])
	by ozlabs.org (Postfix) with ESMTP id 0B32167A65
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Feb 2005 23:21:34 +1100 (EST)
From: Matej Kupljen <matej.kupljen@ultra.si>
To: Stefan Nickl <Stefan.Nickl@kontron.com>
In-Reply-To: <1108555596.12161.10.camel@lucy.pep-kaufbeuren.de>
References: <1108547431.30212.37.camel@mbmatejdebian.ultra.si>
	<1108555596.12161.10.camel@lucy.pep-kaufbeuren.de>
Content-Type: text/plain
Date: Wed, 16 Feb 2005 13:20:50 +0100
Message-Id: <1108556450.30212.54.camel@mbmatejdebian.ultra.si>
Mime-Version: 1.0
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: bdi2000 debugging
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

> > I am trying to debug a problem in a user space application
> > (X windows), which when the process exits, crashes the kernel.
> > ---------------------------------------------------------------
> > Oops: Exception in kernel mode, sig: 4
> > NIP: 000003B4 XER: 00000000 LR: C002B540 SP: C3B8DD10 REGS: c3b8dc60
> 
> Your dump says "sig: 4" (Illegal Instruction), which is different
> from what I see. I get signal 11 (segfault), this is why I'm looking
> after possible memory mapping issues.
> 
> Are you sure you use the right compiler/flags for mpc5200
> when compiling the kernel and X?

Well, I think so, because everything else works.
Mplayer is especially peaky about the compiler, isn't it?
And it works.

Everything works, but when I quit X server, the kernel crashes :-(

NIP points to 000003B4?? Overwritten??
LR points to 0xc002b540 -- 0xc002b478 + 0x00c8   do_generic_file_write

SP seems good.

Still trying to locate it.

BR,
Matej
