Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x1RRp5xxMzDr47
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jul 2017 22:35:18 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Anatolij Gustschin <agust@denx.de>, devicetree@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] powerpc: dts: use #include "..." to include local DT
In-Reply-To: <CAK7LNASvupxqXnwm3hyEq7iGpHyActRbYjZ3v9xyd4qpxdVmLA@mail.gmail.com>
References: <1495602744-18874-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNARnkHTyAMXjPZnOxOkP_b8vc6qvYOv-wf_Fn0eaPSdpeA@mail.gmail.com>
 <87r2yogpc6.fsf@concordia.ellerman.id.au>
 <CAK7LNAS0tkpCuCjjCe=P_Qc2Q12B-+7YgAipko5n+AoeASpQnQ@mail.gmail.com>
 <87y3sv2hky.fsf@concordia.ellerman.id.au>
 <CAK7LNAQ2Ek3VEou_adaH3g8efSnJ7JgvHynzqR9Br4M+q8Mccw@mail.gmail.com>
 <87bmphu0vq.fsf@concordia.ellerman.id.au>
 <CAK7LNAQBbZ7WcXN=3rxi0AQGJC8W_WKtGtmapEziLUre075J=g@mail.gmail.com>
 <CAK7LNASvupxqXnwm3hyEq7iGpHyActRbYjZ3v9xyd4qpxdVmLA@mail.gmail.com>
Date: Mon, 03 Jul 2017 22:35:13 +1000
Message-ID: <87o9t1bsvy.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Masahiro Yamada <yamada.masahiro@socionext.com> writes:

> Hi Michael,
>
> Ping.  Please apply this patch.
>
> I need this to clean up Makefiles in the next development cycle.

Sorry for some reason it didn't land in patchwork, so I keep forgetting
about it.

Have merged it now for 4.13.

cheers
