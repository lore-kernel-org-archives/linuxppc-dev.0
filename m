Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao02.cox.net (fed1rmmtao02.cox.net [68.230.241.37])
	by ozlabs.org (Postfix) with ESMTP id 0002067A6D
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Mar 2005 03:38:51 +1100 (EST)
Date: Wed, 2 Mar 2005 09:37:54 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Roger Larsson <roger.larsson@optronic.se>
Message-ID: <20050302093754.A31614@cox.net>
References: <518B77BB6246D54D9E88FC49AFB0389D1E6C2C@seskoptronicmsx.optronic.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <518B77BB6246D54D9E88FC49AFB0389D1E6C2C@seskoptronicmsx.optronic.local>;
	from roger.larsson@optronic.se on Mon, Feb 28, 2005 at 02:22:46AM +0100
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] ppc4xx_sgdma.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Feb 28, 2005 at 02:22:46AM +0100, Roger Larsson wrote:
> * Dynamic list length
>    1. short lists will not waste a whole page
>    2. no limit in list length
> * End of Transfer termination
> * Residue corrected
> 
> Working with hardware (some tests remaining)

You might want to copy/forward to Wolfgang since this patch is
against the Denx 2.4 tree in ELDK. Since it doesn't mention the
tree (most patches here are for linuxppc-2.4 or 2.6), he might
have missed this thread.

-Matt
