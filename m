Return-Path: <mpn@google.com>
Received: from mail-we0-x231.google.com (mail-we0-x231.google.com
 [IPv6:2a00:1450:400c:c03::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E3B961A034A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 19:53:24 +1000 (EST)
Received: by mail-we0-f177.google.com with SMTP id u56so983420wes.22
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 02:53:19 -0700 (PDT)
Sender: Michal Nazarewicz <mpn@google.com>
From: Michal Nazarewicz <mina86@mina86.com>
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 01/10] DMA, CMA: clean-up log message
In-Reply-To: <xa1toaxyjym3.fsf@mina86.com>
References: <1402543307-29800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1402543307-29800-2-git-send-email-iamjoonsoo.kim@lge.com>
 <87y4x2pwnk.fsf@linux.vnet.ibm.com>
 <20140612055358.GA30128@js1304-P5Q-DELUXE> <xa1toaxyjym3.fsf@mina86.com>
Date: Thu, 12 Jun 2014 11:53:16 +0200
Message-ID: <xa1tegyujvxv.fsf@mina86.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, kvm@vger.kernel.org,
 linux-mm@kvack.org, Gleb Natapov <gleb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 12 2014, Michal Nazarewicz <mina86@mina86.com> wrote:
> I used =E2=80=9Cfunction(arg1, arg2, =E2=80=A6)=E2=80=9D at the *beginnin=
g* of functions when
> the arguments passed to the function were included in the message.  In
> all other cases I left it at just =E2=80=9Cfunction:=E2=80=9D (or just no=
 additional
> prefix).  IMO that's a reasonable strategy.

At closer inspection, I realised drivers/base/dma-contiguous.c is
Marek's code, but the above I think is still reasonable thing to do, so
I'd rather standardise on having =E2=80=9Cfunction(=E2=80=A6)=E2=80=9D only=
 at the beginning of
a function.  Just my 0.02 CHF.

--=20
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=3D./ `o
..o | Computer Science,  Micha=C5=82 =E2=80=9Cmina86=E2=80=9D Nazarewicz   =
 (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>--ooO--(_)--Ooo--
