Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 45F0DDDFC5
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 02:46:12 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m08Fk9qB031670
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jan 2008 10:46:09 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m08Fk1a0079672
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jan 2008 08:46:01 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m08Fk0pm000760
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jan 2008 08:46:00 -0700
Date: Tue, 8 Jan 2008 09:45:58 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v6] qe: add ability to upload QE firmware
Message-ID: <20080108094558.24776be3@zod.rchland.ibm.com>
In-Reply-To: <47839623.4090200@freescale.com>
References: <11997441442105-git-send-email-timur@freescale.com>
	<20080108133747.f717e4b4.sfr@canb.auug.org.au>
	<47839623.4090200@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 08 Jan 2008 09:26:27 -0600
Timur Tabi <timur@freescale.com> wrote:

> Stephen Rothwell wrote:
> 
> > If you use:
> > 	for_each_child_of_node(qe, fw)
> > You don't need to initialise 'fw' in its declararion.
> 
> I can't find for_each_child_of_node.  It's not in Kumar's for-2.6.25 branch.

include/linux/of.h

http://git.kernel.org/?p=linux/kernel/git/galak/powerpc.git;a=blob;f=include/linux/of.h;h=c65af7bd1e9c6369757dfaeeecf74feccea83f97;hb=for-2.6.25

josh
