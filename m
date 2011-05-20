Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 848E0B71A4
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 21 May 2011 08:25:14 +1000 (EST)
Subject: Re: [stable] [PATCH] powerpc: Fix 32-bit SMP build
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
In-Reply-To: <20110520215835.GA14918@kroah.com>
References: <20110520202225.GI25179@zod.rchland.ibm.com>
	<20110520215835.GA14918@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 21 May 2011 08:24:57 +1000
Message-ID: <1305930297.7481.192.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-05-20 at 14:58 -0700, Greg KH wrote:
> On Fri, May 20, 2011 at 04:22:25PM -0400, Josh Boyer wrote:
> > Commit 69e3cea8d5fd526 introduced start_secondary_resume to misc_32.S,
> > however it uses a 64-bit instruction which is not valid on 32-bit
> > platforms.  Use 'stw' instead.
> > 
> > Reported-by: Richard Cochran <richardcochran@gmail.com>
> > Tested-by: Richard Cochran <richardcochran@gmail.com>
> > Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> > 
> > ---
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
> for how to do this properly.
> 
> </formletter>

The function is in a different place in 2.6.39 anyways. I'll do a proper
backport when Linus merges this one.

Cheers,
Ben.
