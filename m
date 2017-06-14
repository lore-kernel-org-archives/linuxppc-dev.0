Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wncZk1X1TzDqKy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 16:45:18 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Anatolij Gustschin <agust@denx.de>, devicetree@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] powerpc: dts: use #include "..." to include local DT
In-Reply-To: <CAK7LNAS0tkpCuCjjCe=P_Qc2Q12B-+7YgAipko5n+AoeASpQnQ@mail.gmail.com>
References: <1495602744-18874-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNARnkHTyAMXjPZnOxOkP_b8vc6qvYOv-wf_Fn0eaPSdpeA@mail.gmail.com>
 <87r2yogpc6.fsf@concordia.ellerman.id.au>
 <CAK7LNAS0tkpCuCjjCe=P_Qc2Q12B-+7YgAipko5n+AoeASpQnQ@mail.gmail.com>
Date: Wed, 14 Jun 2017 16:45:17 +1000
Message-ID: <87y3sv2hky.fsf@concordia.ellerman.id.au>
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
> 2017-06-13 19:21 GMT+09:00 Michael Ellerman <mpe@ellerman.id.au>:
>> Masahiro Yamada <yamada.masahiro@socionext.com> writes:
>>>
>>> (+Anatolij Gustschin <agust@denx.de>)
>>>
>>> Ping.
>>> I am not 100% sure who is responsible for this,
>>> but somebody, could take a look at this patch, please?
>>
>> Have you tested it actually works?
>>
>> It sounds reasonable, and if it behaves as you describe there is no
>> change in behaviour, right?
>
> I do not have access to hardware,
> but it is pretty easy to test this patch.
>
> $ make O=foo ARCH=powerpc CROSS_COMPILE=powerpc-linux-  dts/ac14xx.dtb
>
> gave me the DTB output.
>
> The binary comparison matched with/without this patch,
> so I am sure there is no change in behavior.
>
> Likewise for mpc5121ads and pdm360ng.

Thanks.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>


cheers
