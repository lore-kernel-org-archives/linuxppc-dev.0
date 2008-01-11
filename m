Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6E5D5DDE23
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jan 2008 00:09:57 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0BD9sLg007923
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 08:09:54 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0BD9sOh119890
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 08:09:54 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0BD9rge008855
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 08:09:53 -0500
Date: Fri, 11 Jan 2008 07:09:12 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: Please pull linux-2.6-virtex.git
Message-ID: <20080111070912.3d827e47@zod.rchland.ibm.com>
In-Reply-To: <fa686aa40801090703m5f411795j890bfa714a128b1e@mail.gmail.com>
References: <fa686aa40801082207h24c9b262i55b9756c3c435d7c@mail.gmail.com>
	<20080109063512.1226b979@zod.rchland.ibm.com>
	<87ir23tbgz.fsf@macbook.be.48ers.dk>
	<fa686aa40801090703m5f411795j890bfa714a128b1e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 9 Jan 2008 08:03:31 -0700
"Grant Likely" <grant.likely@secretlab.ca> wrote:

> Gah; teach me to pick up patches right before bed.  I shouldn't have
> picked up the ulite console changes patch just yet.  I've dropped it
> from the series until I have a chance to rework it.  Sorry.
> 
> Here's the new pull request
> 
> The following changes since commit 4f43143f9fbbb679c38d2ff99e44d3aaa00d0fe1:
>   Paul Mackerras (1):
>         Merge branch 'for-2.6.25' of git://git.kernel.org/.../olof/pasemi
> 
> are available in the git repository at:
> 
>   git://git.secretlab.ca/git/linux-2.6-virtex.git virtex-for-2.6.25
> 
> Stephen Neuendorffer (5):
>       [POWERPC] Xilinx: update compatible list for interrupt controller
>       [POWERPC] Xilinx: Add correct compatible list for device tree
> bus bindings.
>       [POWERPC] Xilinx: Update booting-without-of.
>       [POWERPC] Xilinx: updated device tree compatibility to match
> uboot bsp generator.
>       [POWERPC] Xilinx uartlite: Section type fixups

Pulled and pushed out.  I'll ask Paul to pull after I finish chasing
the Warp patches Sean is working on, and the RTC patch from David.

josh
