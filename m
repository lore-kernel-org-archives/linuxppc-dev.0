Return-Path: <olaf@aepfle.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::12])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9B69A2C009A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 19:41:34 +1100 (EST)
Date: Wed, 29 Jan 2014 09:41:12 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Alistair Popple <alistair@popple.id.au>
Subject: Re: [git pull] Please pull powerpc.git next branch
Message-ID: <20140129084112.GA1331@aepfle.de>
References: <1390883744.3872.76.camel@pasglop>
 <20140128150309.GA7428@aepfle.de>
 <1390940395.8524.25.camel@pasglop> <4555187.D5eRSF5r8x@mexican>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4555187.D5eRSF5r8x@mexican>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 29, Alistair Popple wrote:

> Looks like I missed the dart iommu code when changing the iommu table
> initialisation. The patch below should fix it, would you mind testing it Ben?

> +++ b/arch/powerpc/sysdev/dart_iommu.c

> + iommu_table_dart.it_page_shift = IOMMU_PAGE_SHIFT_4K;


Yes, that fixes it for me. Thanks!

Olaf
