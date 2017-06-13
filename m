Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wn9B36HtfzDqNK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 23:10:51 +1000 (AEST)
Date: Tue, 13 Jun 2017 15:10:45 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Michael Ellerman <mpe@ellerman.id.au>, Masahiro Yamada
 <yamada.masahiro@socionext.com>, linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring
 <robh+dt@kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH] powerpc: dts: use #include "..." to include local DT
Message-ID: <20170613151045.1faa93e4@crub>
In-Reply-To: <87r2yogpc6.fsf@concordia.ellerman.id.au>
References: <1495602744-18874-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNARnkHTyAMXjPZnOxOkP_b8vc6qvYOv-wf_Fn0eaPSdpeA@mail.gmail.com>
 <87r2yogpc6.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 13 Jun 2017 20:21:45 +1000
Michael Ellerman mpe@ellerman.id.au wrote:

>Masahiro Yamada <yamada.masahiro@socionext.com> writes:
...
>> Ping.
>> I am not 100% sure who is responsible for this,
>> but somebody, could take a look at this patch, please?  
>
>Have you tested it actually works?
>
>It sounds reasonable, and if it behaves as you describe there is no
>change in behaviour, right?

yes, these dtbs build with this patch and I've tested with
mpc5121ads.dtb.

Thanks,
Anatolij
