Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zC1mG5yVWzDqvJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jan 2018 19:53:18 +1100 (AEDT)
Date: Thu, 4 Jan 2018 09:53:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
 alpha <linux-alpha@vger.kernel.org>,
 arcml <linux-snps-arc@lists.infradead.org>,
 linux-arm-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net,
 linux-c6x-dev@linux-c6x.org, Cris <linux-cris-kernel@axis.com>,
 "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
 linux-ia64@vger.kernel.org, linux-m68k <linux-m68k@lists.linux-m68k.org>,
 "open list:METAG ARCHITECTURE" <linux-metag@vger.kernel.org>,
 Michal Simek <monstr@monstr.eu>,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 Parisc List <linux-parisc@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org,
 linux-s390 <linux-s390@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 sparclinux <sparclinux@vger.kernel.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 the arch/x86 maintainers <x86@kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 02/67] alpha: mark jensen as broken
Message-ID: <20180104085315.GD3251@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
 <20171229081911.2802-3-hch@lst.de>
 <CAMuHMdUXSMuQ=RoZp86CODVk5Ubd3R+jtqOur_Uqnu+7h_m9AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMuHMdUXSMuQ=RoZp86CODVk5Ubd3R+jtqOur_Uqnu+7h_m9AA@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 02, 2018 at 11:36:00AM +0100, Geert Uytterhoeven wrote:
> Hi Christoph,
> 
> On Fri, Dec 29, 2017 at 9:18 AM, Christoph Hellwig <hch@lst.de> wrote:
> > CONFIG_ALPHA_JENSEN has failed to compile since commit aca05038
> > ("alpha/dma: use common noop dma ops"), so mark it as broken.
> 
> unknown revision or path not in the working tree.
> Ah, you dropped the leading "6":
> 6aca0503847f6329460b15b3ab2b0e30bb752793
> is less than 2 years old, though.

I'll fix the reference.

But 23 month of a whole sub-architecture not compiling should still be
enough to mark it broken.
