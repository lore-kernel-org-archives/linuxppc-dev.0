Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8g1d2nH2zDq6j
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 11:40:37 +1100 (AEDT)
In-Reply-To: <817567b2-cdf6-7f7b-6041-9a026ea10a0f@users.sourceforge.net>
To: SF Markus Elfring <elfring@users.sourceforge.net>,
 linuxppc-dev@lists.ozlabs.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Wei Yang <weiyang@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Julia Lawall <julia.lawall@lip6.fr>, kernel-janitors@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: powerpc/powernv/pci: Use kmalloc_array() in two functions
Message-Id: <3v8g1d0rqgz9tk0@ozlabs.org>
Date: Fri, 27 Jan 2017 11:40:36 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-08-24 at 20:36:54 UTC, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 24 Aug 2016 22:26:37 +0200
> 
> A multiplication for the size determination of a memory allocation
> indicated that an array data structure should be processed.
> Thus reuse the corresponding function "kmalloc_array".
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/fb37e12896c1ba0407012fe8cdc0b0

cheers
