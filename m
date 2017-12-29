Return-Path: <julian.calaby@gmail.com>
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com
 [IPv6:2a00:1450:400c:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z7MpD3L0dzDqtT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Dec 2017 21:12:20 +1100 (AEDT)
Received: by mail-wm0-x243.google.com with SMTP id i11so47294276wmf.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Dec 2017 02:12:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171229081911.2802-18-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
 <20171229081911.2802-18-hch@lst.de>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Fri, 29 Dec 2017 21:11:56 +1100
Message-ID: <CAGRGNgW1qwLcCAvU2Jc=3_7b-0Bu016to3cQUgVsc+ca0No_6g@mail.gmail.com>
Subject: Re: [PATCH 17/67] microblaze: rename dma_direct to dma_microblaze
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org,
 "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>,
 adi-buildroot-devel@lists.sourceforge.net, linux-c6x-dev@linux-c6x.org,
 linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
 linux-mips@linux-mips.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 patches@groups.riscv.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org, linux-arch@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Christoph,

On Fri, Dec 29, 2017 at 7:18 PM, Christoph Hellwig <hch@lst.de> wrote:
> This frees the dma_direct_* namespace for a generic implementation.

Don't you mean "dma_nommu" not "dma_microblaze" in the subject line?

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
