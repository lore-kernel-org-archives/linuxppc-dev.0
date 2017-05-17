Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wSnjv65JHzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 May 2017 07:38:11 +1000 (AEST)
Date: Wed, 17 May 2017 14:37:17 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Pavel Machek <pavel@denx.de>
Cc: sr@denx.de, jwboyer@linux.vnet.ibm.com, robh+dt@kernel.org,
 mark.rutland@arm.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 trivial@kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] powerpc/sequoia: fix NAND partitions not to overlap
Message-Id: <20170517143717.ad818a2282378fc7a38af1ff@linux-foundation.org>
In-Reply-To: <20170517120613.GA583@amd>
References: <20170402100535.GA18340@amd>
	<20170517120613.GA583@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 17 May 2017 14:06:13 +0200 Pavel Machek <pavel@denx.de> wrote:

> On Sun 2017-04-02 12:05:36, Pavel Machek wrote:
> > Fix overlapping NAND partitions.
> > 
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> Ping? Two partitions at same place are bad news...

Please expand on "bad news"?  What are the runtime effects of this
change?  Decisions about which kernel(s) to patch depend on this info.
