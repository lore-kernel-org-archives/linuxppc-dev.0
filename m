Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wpv1B1NVTzDq88
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 18:39:10 +1000 (AEST)
Date: Fri, 16 Jun 2017 10:39:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>, the arch/x86 maintainers <x86@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
 "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 openrisc@lists.librecores.org,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 sparclinux <sparclinux@vger.kernel.org>,
 "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
 dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
 DRI Development <dri-devel@lists.freedesktop.org>,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 iommu@lists.linux-foundation.org,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 33/44] openrisc: remove arch-specific dma_supported
 implementation
Message-ID: <20170616083907.GB10582@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
 <20170608132609.32662-34-hch@lst.de>
 <CAMuHMdUPeFJJtz8eJkQEAR-2w9oHt-fXeGHvvKFLfU2A4YyviQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMuHMdUPeFJJtz8eJkQEAR-2w9oHt-fXeGHvvKFLfU2A4YyviQ@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 09, 2017 at 02:20:42PM +0200, Geert Uytterhoeven wrote:
> Hi Christoph,
> 
> On Thu, Jun 8, 2017 at 3:25 PM, Christoph Hellwig <hch@lst.de> wrote:
> > This implementation is simply bogus - hexagon only has a simple
> 
> openrisc?

Yeah.
