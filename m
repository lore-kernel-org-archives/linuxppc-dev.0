Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 89D18DDE27
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Dec 2007 11:27:35 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lB30RSV9024619
	for <linuxppc-dev@ozlabs.org>; Sun, 2 Dec 2007 19:27:28 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lB30RSMX112874
	for <linuxppc-dev@ozlabs.org>; Sun, 2 Dec 2007 19:27:28 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lB30RSJR025003
	for <linuxppc-dev@ozlabs.org>; Sun, 2 Dec 2007 19:27:28 -0500
Date: Sun, 2 Dec 2007 18:25:02 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Please pull powerpc.git merge branch
Message-ID: <20071202182502.67c07a2c@zod.rchland.ibm.com>
In-Reply-To: <18259.15345.627820.551644@cargo.ozlabs.ibm.com>
References: <18259.15345.627820.551644@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 3 Dec 2007 10:12:49 +1100
Paul Mackerras <paulus@samba.org> wrote:

> Linus,
> 
> Please do
> 
> git pull \
> git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge
> 
> There are two commits there; one reverts a patch which was causing
> some machines to fail to come back up when rebooting, and the other
> only touches a couple of defconfigs.
> 
> Thanks,
> Paul.
> 
>  arch/powerpc/kernel/rtas.c             |   12 ++++++------
>  arch/powerpc/platforms/pseries/setup.c |    3 +--
>  arch/ppc/configs/ml300_defconfig       |    2 +-
>  arch/ppc/configs/ml403_defconfig       |    2 +-
>  include/asm-powerpc/rtas.h             |    3 +--
>  5 files changed, 10 insertions(+), 12 deletions(-)
> 
> Grant Likely (1):
>       [POWERPC] Remove xmon from ml300 and ml403 defconfig in arch/ppc

Thanks Paul.  I had this one queued for you to pull, but you beat me to
it.

josh
