Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DD4BADDDFA
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Feb 2009 22:28:39 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n1QBTXwR031826
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Feb 2009 06:29:33 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n1QBSZ1l194544
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Feb 2009 06:28:35 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n1QBRLYC003980
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Feb 2009 06:27:21 -0500
Date: Thu, 26 Feb 2009 06:28:18 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [git pull] Please pull powerpc.git merge branch
Message-ID: <20090226112818.GF19612@zod.rchland.ibm.com>
References: <1235621244.8805.340.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1235621244.8805.340.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 26, 2009 at 03:07:24PM +1100, Benjamin Herrenschmidt wrote:
>Hi Linus !
>
>Please pull a few regression fixes for powerpc.
>
>Cheers,
>Ben.
>
>The following changes since commit 169d418b127b98a3e464e9c4b807ad083760f98c:
>  Linus Torvalds (1):
>        Merge branch 'for-linus' of git://git.kernel.org/.../tiwai/sound-2.6
>
>are available in the git repository at:
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge
>
>Mark Nelson (2):
>      powerpc: Fix 64bit memcpy() regression
>      powerpc: Fix 64bit __copy_tofrom_user() regression
>
>Michael Neuling (1):
>      powerpc: Fix load/store float double alignment handler

You don't seem to have your fix for PCI 2.x stuff on 4xx here.  Patchwork
has it in accepted state and Geert has been asking if it would go in 2.6.29.

Any idea what is up with that one?

josh
