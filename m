Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6842067A46
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Mar 2005 06:12:11 +1000 (EST)
Date: Tue, 29 Mar 2005 12:12:09 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Kumar Gala <galak@freescale.com>
Message-ID: <20050329201209.GB30850@gate.ebshome.net>
References: <Pine.LNX.4.61.0503291039180.15390@blarg.somerset.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.61.0503291039180.15390@blarg.somerset.sps.mot.com>
Cc: Andrew Morton <akpm@osdl.org>, shall@mvista.com,
	linux-kernel@vger.kernel.org,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] ppc32: CPM2 PIC cleanup
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Mar 29, 2005 at 10:42:29AM -0600, Kumar Gala wrote:
> Andrew,
> 
> Cleaned up the CPM2 interrupt controller code:
> * Added the ability to offset the IRQs
> * Refactored common PIC init code out of platform files
> * Fixed IRQ offsets on MPC85xx so it can handle properly handled multiple 
> interrupt controllers (i8259, CPM2 PIC, and OpenPIC)
> 
> Signed-off-by: Jason McMullan <jason.mcmullan@timesys.com>
> Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
> 

[snip]

Guys, while you are at it, could we renumber irq_to_siubit[] array in 
cpm2_pic.c so we can get rid of "1 << (31 - bit)" expressions and 
simply use "1 << bit"? I know, it's a minor thing, but you are 
cleaning this stuff anyway, why not make it super clean :).

--
Eugene
