Return-Path: <stefan.nickl@kontron.com>
Received: from kom-mail1.kontron-modular.com (unknown [62.159.155.196])
	by ozlabs.org (Postfix) with ESMTP id B8FBD67A71
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Feb 2005 23:06:41 +1100 (EST)
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: Matej Kupljen <matej.kupljen@ultra.si>
In-Reply-To: <1108547431.30212.37.camel@mbmatejdebian.ultra.si>
References: <1108547431.30212.37.camel@mbmatejdebian.ultra.si>
Content-Type: text/plain
Date: Wed, 16 Feb 2005 13:06:36 +0100
Message-Id: <1108555596.12161.10.camel@lucy.pep-kaufbeuren.de>
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

On Wed, 2005-02-16 at 10:50 +0100, Matej Kupljen wrote:
> Hi 
> 
> I am trying to debug a problem in a user space application
> (X windows), which when the process exits, crashes the kernel.
> ---------------------------------------------------------------
> Oops: Exception in kernel mode, sig: 4
> NIP: 000003B4 XER: 00000000 LR: C002B540 SP: C3B8DD10 REGS: c3b8dc60

Your dump says "sig: 4" (Illegal Instruction), which is different
from what I see. I get signal 11 (segfault), this is why I'm looking
after possible memory mapping issues.

Are you sure you use the right compiler/flags for mpc5200
when compiling the kernel and X?

-- 
Stefan Nickl
Kontron Modular Computers
