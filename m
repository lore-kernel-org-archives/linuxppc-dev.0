Return-Path: <rsiemsen@rossvideo.com>
Received: from server06.rossvideo.com (unknown [209.87.241.202])
	by ozlabs.org (Postfix) with ESMTP id E9EF267A67
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 Feb 2005 08:31:51 +1100 (EST)
Message-ID: <421F966D.4060206@rossvideo.com>
Date: Fri, 25 Feb 2005 16:19:41 -0500
From: Ralph Siemsen <rsiemsen@rossvideo.com>
MIME-Version: 1.0
To: Matt Porter <mporter@kernel.crashing.org>
References: <1628E43D99629C46988BE46087A3FBB91C4AA7@ep-01.EmbeddedPlanet.local>	<421F89A0.8070502@sandburst.com>
	<20050225133055.A28918@cox.net>
In-Reply-To: <20050225133055.A28918@cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: 2.6 4xx GPIO OCP driver?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Matt Porter wrote:

> I didn't bother merging it upstream at one time. It wasn't clear
> if the driver had any value over just mmaping /dev/mem to bang
> on the couple gpio registers directly. [...]

Will that work on the 440 where the devices sit above 4GB mark?  Or must 
one rely on there being an existing TLB mapping to bring them into 
32-bit space?

-Ralph
