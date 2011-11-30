Return-Path: <B04825@freescale.com>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe003.messaging.microsoft.com
 [213.199.154.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id A48151007D1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2011 11:08:55 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: [PATCH][RFC] fsldma: fix performance degradation by optimizing
 spinlock use.
Date: Wed, 30 Nov 2011 00:08:44 +0000
Message-ID: <CAOZdJXWX9EHfcXTuVag+-MvUvqnA7bA5RjmLx4jE5Cu5JmQdvg@mail.gmail.com>
References: <1321937705-19587-1-git-send-email-b29237@freescale.com>
 <20111122185924.GA23323@ovro.caltech.edu>
 <DBB740589CE8814680DECFE34BE197AB148CDD@039-SN1MPN1-006.039d.mgd.msft.net>
 <20111128163814.GA10919@ovro.caltech.edu>
 <3F607A5180246847A760FD34122A1E052E07B7@039-SN1MPN1-003.039d.mgd.msft.net>
 <20111129172539.GB15331@ovro.caltech.edu>
In-Reply-To: <20111129172539.GB15331@ovro.caltech.edu>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: Li Yang-R58472 <r58472@freescale.com>,
 "vinod.koul@intel.com" <vinod.koul@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Shi Xuelin-B29237 <B29237@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 29, 2011 at 11:25 AM, Ira W. Snyder <iws@ovro.caltech.edu> wrot=
e:

> I believe that you are correct, for powerpc. However, anything outside
> of arch/powerpc shouldn't assume it only runs on powerpc. I wouldn't be
> surprised to see fsldma running on an iMX someday (ARM processor).

I certainly would.  The i.MX chips have their own DMA controller.  The
DMA controller that fsldma.c works with is unique to Freescale's 83xx,
85xx, and QorIQ chips.

--=20
Timur Tabi
Linux kernel developer at Freescale=
