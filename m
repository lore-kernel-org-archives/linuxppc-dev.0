Return-Path: <greg@kroah.com>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 182F4B719A
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 21 May 2011 07:59:13 +1000 (EST)
Date: Fri, 20 May 2011 14:58:35 -0700
From: Greg KH <greg@kroah.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [stable] [PATCH] powerpc: Fix 32-bit SMP build
Message-ID: <20110520215835.GA14918@kroah.com>
References: <20110520202225.GI25179@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110520202225.GI25179@zod.rchland.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 20, 2011 at 04:22:25PM -0400, Josh Boyer wrote:
> Commit 69e3cea8d5fd526 introduced start_secondary_resume to misc_32.S,
> however it uses a 64-bit instruction which is not valid on 32-bit
> platforms.  Use 'stw' instead.
> 
> Reported-by: Richard Cochran <richardcochran@gmail.com>
> Tested-by: Richard Cochran <richardcochran@gmail.com>
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> 
> ---

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
