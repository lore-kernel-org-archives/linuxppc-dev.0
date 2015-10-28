Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 16AE61A0282
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 11:43:33 +1100 (AEDT)
Date: Tue, 27 Oct 2015 18:00:11 -0700 (PDT)
Message-Id: <20151027.180011.1597667162481700758.davem@davemloft.net>
To: julian.calaby@gmail.com
Cc: nacc@linux.vnet.ibm.com, willy@linux.intel.com, keith.busch@intel.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 aik@ozlabs.ru, david@gibson.dropbear.id.au, hch@infradead.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 0/5 v3] Fix NVMe driver support on Power with 32-bit DMA
From: David Miller <davem@davemloft.net>
In-Reply-To: <CAGRGNgVvvcjHFjU4H1wnj6bGy69X19d-xR9O+Xc-p-TmtPxNgQ@mail.gmail.com>
References: <CAGRGNgXV+RJvjOBe351HyguYkonQ8F=CM3uZTijcqoQg6ArAcw@mail.gmail.com>
 <20151027234018.GA48779@linux.vnet.ibm.com>
 <CAGRGNgVvvcjHFjU4H1wnj6bGy69X19d-xR9O+Xc-p-TmtPxNgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Julian Calaby <julian.calaby@gmail.com>
Date: Wed, 28 Oct 2015 10:43:35 +1100

> You'll be CCing the maintainers of each architecture on the patches to
> add the functions, so if they do have specific requirements, I'm sure
> they'll let you know or provide patches.

People miss things, maintainers get busy, so while a CC: is important
and appreciated, it doesn't ensure a correct implementation is likely
to result.

Personally, I'd much rather my arch stop building so I have to go in
there to explicitly look at the reason why and make sure I fill in the
missing pieces properly and accurately.
