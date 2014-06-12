Return-Path: <mpn@google.com>
Received: from mail-wi0-x22e.google.com (mail-wi0-x22e.google.com
 [IPv6:2a00:1450:400c:c05::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6CFF81A034A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 19:55:15 +1000 (EST)
Received: by mail-wi0-f174.google.com with SMTP id bs8so3193083wib.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 02:55:12 -0700 (PDT)
Sender: Michal Nazarewicz <mpn@google.com>
From: Michal Nazarewicz <mina86@mina86.com>
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v2 03/10] DMA,
 CMA: separate core cma management codes from DMA APIs
In-Reply-To: <1402543307-29800-4-git-send-email-iamjoonsoo.kim@lge.com>
References: <1402543307-29800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1402543307-29800-4-git-send-email-iamjoonsoo.kim@lge.com>
Date: Thu, 12 Jun 2014 11:55:09 +0200
Message-ID: <xa1tbntyjvuq.fsf@mina86.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, kvm@vger.kernel.org,
 linux-mm@kvack.org, Gleb Natapov <gleb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 12 2014, Joonsoo Kim <iamjoonsoo.kim@lge.com> wrote:
> To prepare future generalization work on cma area management code,
> we need to separate core cma management codes from DMA APIs.
> We will extend these core functions to cover requirements of
> ppc kvm's cma area management functionality in following patches.
> This separation helps us not to touch DMA APIs while extending
> core functions.
>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: Michal Nazarewicz <mina86@mina86.com>


--=20
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=3D./ `o
..o | Computer Science,  Micha=C5=82 =E2=80=9Cmina86=E2=80=9D Nazarewicz   =
 (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>--ooO--(_)--Ooo--
