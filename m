Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao07.cox.net (fed1rmmtao07.cox.net [68.230.241.32])
	by ozlabs.org (Postfix) with ESMTP id 36395679E1
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Jun 2005 10:20:52 +1000 (EST)
Date: Thu, 16 Jun 2005 17:20:49 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Avni Hillel-R58467 <hillel.avni@freescale.com>
Message-ID: <20050616172049.B4541@cox.net>
References: <D39C8B3D64A0D511A61E00D0B7828EEA0C076452@zil05exm01.ea.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <D39C8B3D64A0D511A61E00D0B7828EEA0C076452@zil05exm01.ea.freescale.net>;
	from hillel.avni@freescale.com on Thu, Jun 16, 2005 at 01:44:48PM +0300
Cc: Kardonik Michael-R58108 <Michael.Kardonik@freescale.com>,
	"'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Subject: Re: Adding RapidIO to Linux
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Jun 16, 2005 at 01:44:48PM +0300, Avni Hillel-R58467 wrote:
> Hi Matt,
>  
> I want to install:
>  
> [PATCH][1/3] RapidIO support: core
> [PATCH][2/3] RapidIO support: ppc32
> [PATCH][3/3] RapidIO support: net driver over messaging
>  
> 1. What specific version of Linux should I start from?

2.6.12-rc6 is the latest release that you can apply these against.
Or they can go against the linux-2.6 git tree.
  
> 2. Are there any more patches that are relevant to RIO?
  
Several sets of patches were posted after this set, and then
there were several additions posted against the -mm tree.
Check the list archives, I cced this list on everything.

You could get the 2.6.12-rc6-mm1 patch which has a later version
of these patches.  There are additional changes in the -mm tree
but there isn't a unified patch of them until another -mm patch
is released.

-Matt
