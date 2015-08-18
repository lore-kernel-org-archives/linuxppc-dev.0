Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5467E1A0035
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 15:38:29 +1000 (AEST)
Date: Tue, 18 Aug 2015 07:38:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: arnd@arndb.de, linux@arm.linux.org.uk, catalin.marinas@arm.com,
 will.deacon@arm.com, ysato@users.sourceforge.jp, monstr@monstr.eu,
 jonas@southpole.se, cmetcalf@ezchip.com, gxt@mprc.pku.edu.cn,
 x86@kernel.org, linux-alpha@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: provide more common DMA API functions V2
Message-ID: <20150818053825.GA20771@lst.de>
References: <1439795216-32189-1-git-send-email-hch@lst.de>
 <20150817142429.95a3965e0b35d0f35d3c4cfe@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150817142429.95a3965e0b35d0f35d3c4cfe@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 17, 2015 at 02:24:29PM -0700, Andrew Morton wrote:
> 110254 bytes saved, shrinking the kernel by a whopping 0.17%. 
> Thoughts?

Sounds fine to me.

> 
> I'll merge these 5 patches for 4.3.  That means I'll release them into
> linux-next after 4.2 is released.

So you only add for-4.3 code to -next after 4.2 is odd?  Isn't thast the
wrong way around?
