Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zC1fl6yzrzDqp0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jan 2018 19:48:31 +1100 (AEDT)
Date: Thu, 4 Jan 2018 09:48:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: Julian Calaby <julian.calaby@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 linux-ia64@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>,
 sparclinux <sparclinux@vger.kernel.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>, linux-c6x-dev@linux-c6x.org,
 "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 arcml <linux-snps-arc@lists.infradead.org>,
 adi-buildroot-devel@lists.sourceforge.net,
 linux-m68k <linux-m68k@lists.linux-m68k.org>, patches@groups.riscv.org,
 "open list:METAG ARCHITECTURE" <linux-metag@vger.kernel.org>,
 "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>,
 Michal Simek <monstr@monstr.eu>,
 Parisc List <linux-parisc@vger.kernel.org>,
 Cris <linux-cris-kernel@axis.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 alpha <linux-alpha@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 16/67] powerpc: rename dma_direct_ to dma_nommu_
Message-ID: <20180104084828.GA3251@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
 <20171229081911.2802-17-hch@lst.de> <878tdgtwzp.fsf@concordia.ellerman.id.au>
 <CAMuHMdWWus2kNSOzS94k-3678826W1YjKwCWTquu3hBLZ80cvw@mail.gmail.com>
 <87h8s3cvel.fsf@concordia.ellerman.id.au>
 <CAMuHMdWYDz_jHNxQ-B8944520R-myzHkjkL1rKWUjA38inU7cw@mail.gmail.com>
 <CAGRGNgV+DnZAAtiE5oe8rxp4=_JHJrtSQc8F5jrgN0rgYKfwjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGRGNgV+DnZAAtiE5oe8rxp4=_JHJrtSQc8F5jrgN0rgYKfwjA@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 03, 2018 at 07:19:46PM +1100, Julian Calaby wrote:
> If this is indeed a linear mapping, can we just remove this and
> replace it with the new "generic" mapping being introduced by this
> patchset?

That is the long-term plan.  But as the powerpc one includes support
for non-coherent DMA it will have to wait for the next batch.
