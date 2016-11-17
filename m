Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKKYF4hP5zDvs8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 23:04:17 +1100 (AEDT)
In-Reply-To: <1454514630-29269-24-git-send-email-b.zolnierkie@samsung.com>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 b.zolnierkie@samsung.com
Subject: Re: [RFT] powerpc: convert storcenter_defconfig to use libata PATA
 drivers
Message-Id: <3tKKYF2KnRz9t5m@ozlabs.org>
Date: Thu, 17 Nov 2016 23:04:17 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-03-02 at 15:50:30 UTC, Bartlomiej Zolnierkiewicz wrote:
> IDE subsystem has been deprecated since 2009 and the majority
> (if not all) of Linux distributions have switched to use
> libata for ATA support exclusively.  However there are still
> some users (mostly old or/and embedded non-x86 systems) that
> have not converted from using IDE subsystem to libata PATA
> drivers.  This doesn't seem to be good thing in the long-term
> for Linux as while there is less and less PATA systems left
> in use:
> 
> * testing efforts are divided between two subsystems
> 
> * having duplicate drivers for same hardware confuses users
> 
> This patch converts storcenter_defconfig to use libata PATA
> drivers.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1aed61f9c9664cc7331079a66aba99

cheers
