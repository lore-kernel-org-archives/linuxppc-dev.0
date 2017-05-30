Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcSX40c4JzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 19:11:16 +1000 (AEST)
In-Reply-To: <20170402100535.GA18340@amd>
To: Pavel Machek <pavel@denx.de>, sr@denx.de, jwboyer@linux.vnet.ibm.com,
 robh+dt@kernel.org, mark.rutland@arm.com, benh@kernel.crashing.org,
 paulus@samba.org, devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/sequoia: fix NAND partitions not to overlap
Message-Id: <3wcSX36jzsz9s5j@ozlabs.org>
Date: Tue, 30 May 2017 19:11:15 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2017-04-02 at 10:05:36 UTC, Pavel Machek wrote:
> Fix overlapping NAND partitions.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/70a92003de599ff2f15815b3d9c445

cheers
