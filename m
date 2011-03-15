Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B5ACBB700D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Mar 2011 00:19:26 +1100 (EST)
Received: from d01dlp02.pok.ibm.com (d01dlp02.pok.ibm.com [9.56.224.85])
	by e6.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p2FCt5gh013395
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2011 08:55:06 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id C93856E8036
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Mar 2011 09:19:22 -0400 (EDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p2FDJMEE456174
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2011 09:19:22 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p2FDJL9d014576
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2011 07:19:22 -0600
Date: Tue, 15 Mar 2011 09:19:24 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: Please pull 'next' branch of 4xx tree
Message-ID: <20110315131919.GG3662@zod.rchland.ibm.com>
References: <20110215145445.GA2847@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110215145445.GA2847@zod.rchland.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 15, 2011 at 09:54:45AM -0500, Josh Boyer wrote:
>Hi Ben,
>
>Please pull the 'next' branch of the 4xx tree.  These commits have been
>sitting there for a while and I wanted to get them into your branch
>before tackling the latest round of 476 stuff from Shaggy.

Ben, I don't see any of these in your -next branch.  Did you ever pull
this?

josh

>The following changes since commit 5d7d8072edc11080a7cf6cc37c9f4e61ca1e93c9:
>
>  powerpc/pseries: Fix build of topology stuff without CONFIG_NUMA (2011-01-12 10:56:29 +1100)
>
>are available in the git repository at:
>  ssh://master.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git next
>
>Dave Kleikamp (2):
>      powerpc/476: define specific cpu table entry DD2 core
>      powerpc/476: Workaround for PLB6 hang
>
>Rupjyoti Sarmah (1):
>      powerpc/44x: PHY fixup for USB on canyonlands board
>
>Tirumala Marri (1):
>      powerpc/44x: Add USB DWC DTS entry to Canyonlands board
>
> arch/powerpc/boot/dts/canyonlands.dts      |   24 +++++
> arch/powerpc/include/asm/cputable.h        |    3 +-
> arch/powerpc/kernel/cputable.c             |   22 ++++-
> arch/powerpc/mm/tlb_nohash_low.S           |   35 +++++++
> arch/powerpc/platforms/44x/44x.h           |    4 +
> arch/powerpc/platforms/44x/Kconfig         |    1 -
> arch/powerpc/platforms/44x/Makefile        |    1 +
> arch/powerpc/platforms/44x/canyonlands.c   |  134 ++++++++++++++++++++++++++++
> arch/powerpc/platforms/44x/ppc44x_simple.c |    1 -
> 9 files changed, 218 insertions(+), 7 deletions(-)
> create mode 100644 arch/powerpc/platforms/44x/canyonlands.c
>
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@lists.ozlabs.org
>https://lists.ozlabs.org/listinfo/linuxppc-dev
