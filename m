Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C89DF1A0A2F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 11:31:13 +1100 (AEDT)
Message-ID: <1445992192.1856.23.camel@kernel.crashing.org>
Subject: Re: [PATCH 0/5 v3] Fix NVMe driver support on Power with 32-bit DMA
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Julian Calaby <julian.calaby@gmail.com>, Nishanth Aravamudan
 <nacc@linux.vnet.ibm.com>
Cc: David Miller <davem@davemloft.net>, willy@linux.intel.com,
 keith.busch@intel.com, paulus@samba.org, mpe@ellerman.id.au,
 aik@ozlabs.ru, david@gibson.dropbear.id.au,
 Christoph Hellwig <hch@infradead.org>, linux-nvme@lists.infradead.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, sparclinux <sparclinux@vger.kernel.org>
Date: Wed, 28 Oct 2015 09:29:52 +0900
In-Reply-To: <CAGRGNgVvvcjHFjU4H1wnj6bGy69X19d-xR9O+Xc-p-TmtPxNgQ@mail.gmail.com>
References: <20151023205420.GA10197@linux.vnet.ibm.com>
 <20151026.182746.1323901353520152838.davem@davemloft.net>
 <20151027222010.GD7716@linux.vnet.ibm.com>
 <CAGRGNgXV+RJvjOBe351HyguYkonQ8F=CM3uZTijcqoQg6ArAcw@mail.gmail.com>
 <20151027234018.GA48779@linux.vnet.ibm.com>
 <CAGRGNgVvvcjHFjU4H1wnj6bGy69X19d-xR9O+Xc-p-TmtPxNgQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-10-28 at 10:43 +1100, Julian Calaby wrote:
> Hi Nishanth,
> You'll be CCing the maintainers of each architecture on the patches
> to
> add the functions, so if they do have specific requirements, I'm sure
> they'll let you know or provide patches.

That sort of accross-all-arch change tend to take forever. I'd rather
get the existing series in to fix the problem, we can look into
improving things later but I tend to think that the default of using
PAGE_SHIFT in asm-generic will be fine for most archs.

Ben.
