Return-Path: <mpn@google.com>
Received: from mail-we0-x230.google.com (mail-we0-x230.google.com
 [IPv6:2a00:1450:400c:c03::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A5E691A0A1F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2014 18:25:03 +1000 (EST)
Received: by mail-we0-f176.google.com with SMTP id u56so4020089wes.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2014 01:24:59 -0700 (PDT)
Sender: Michal Nazarewicz <mpn@google.com>
From: Michal Nazarewicz <mina86@mina86.com>
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [RFC PATCH 2/3] DMA,
 CMA: use general CMA reserved area management framework
In-Reply-To: <20140610024910.GB19036@js1304-P5Q-DELUXE>
References: <1401757919-30018-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1401757919-30018-3-git-send-email-iamjoonsoo.kim@lge.com>
 <xa1twqcyjx3z.fsf@mina86.com> <20140610024910.GB19036@js1304-P5Q-DELUXE>
Date: Wed, 11 Jun 2014 10:24:55 +0200
Message-ID: <xa1t38fb3lbc.fsf@mina86.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, kvm@vger.kernel.org,
 linux-mm@kvack.org, Gleb Natapov <gleb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 10 2014, Joonsoo Kim <iamjoonsoo.kim@lge.com> wrote:
> Without including device.h, build failure occurs.
> In dma-contiguous.h, we try to access to dev->cma_area, so we need
> device.h. In the past, we included it luckily by swap.h in
> drivers/base/dma-contiguous.c. Swap.h includes node.h and then node.h
> includes device.h, so we were happy. But, in this patch, I remove
> 'include <linux/swap.h>' so we need to include device.h explicitly.

Ack.

--=20
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=3D./ `o
..o | Computer Science,  Micha=C5=82 =E2=80=9Cmina86=E2=80=9D Nazarewicz   =
 (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>--ooO--(_)--Ooo--
