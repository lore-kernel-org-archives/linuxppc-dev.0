Return-Path: <greg@kroah.com>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DAB7FB6F9D
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jun 2011 15:56:53 +1000 (EST)
Date: Fri, 3 Jun 2011 14:56:50 +0900
From: Greg KH <greg@kroah.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [stable] [PATCH] 2.6.39 powerpc: Fix 32-bit SMP build
Message-ID: <20110603055650.GB21323@kroah.com>
References: <20110530122621.GD2557@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110530122621.GD2557@zod.rchland.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 30, 2011 at 08:26:21AM -0400, Josh Boyer wrote:
> Backport upstream commit 6de06f313a65d0ec
>     
> Commit fa3f82c8bb7acb ("powerpc/smp: soft-replugged CPUs must go back to
> start_secondary") introduced start_secondary_resume to head_32.S, however
> it uses a 64-bit instruction which is not valid on 32-bit platforms.  Use
> 'stw' instead.
>     
> CC: stable@kernel.org
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

This doesn't apply either:

patching file arch/powerpc/kernel/head_32.S
Hunk #1 FAILED at 896.
1 out of 1 hunk FAILED -- saving rejects to file arch/powerpc/kernel/head_32.S.rej

Please send something that at least applies, and hopefully builds...

greg k-h
