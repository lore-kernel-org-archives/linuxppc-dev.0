Return-Path: <B35362@freescale.com>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
 [65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 80984B7237
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2011 13:05:22 +1100 (EST)
Message-ID: <4EC5BE16.9080205@freescale.com>
Date: Fri, 18 Nov 2011 10:08:22 +0800
From: LiuShuo <b35362@freescale.com>
MIME-Version: 1.0
To: <dedekind1@gmail.com>
Subject: Re: [PATCH 2/3] mtd/nand : set Nand flash page address to FBAR and
 FPAR correctly
References: <1321349355-1639-1-git-send-email-b35362@freescale.com>	
 <1321349355-1639-2-git-send-email-b35362@freescale.com>
 <1321568016.2272.29.camel@koala>
In-Reply-To: <1321568016.2272.29.camel@koala>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: Artem.Bityutskiy@nokia.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Tang Yuantian <b29983@freescale.com>,
 linux-mtd@lists.infradead.org, Jerry Huang <Chang-Ming.Huang@freescale.com>,
 scottwood@freescale.com, akpm@linux-foundation.org, dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ok and I want to add another patch before 3/3.

-LiuShuo
> On Tue, 2011-11-15 at 17:29 +0800, b35362@freescale.com wrote:
>> From: Liu Shuo<b35362@freescale.com>
>>
>> If we use the Nand flash chip whose number of pages in a block is greater
>> than 64(for large page), we must treat the low bit of FBAR as being the
>> high bit of the page address due to the limitation of FCM, it simply uses
>> the low 6-bits (for large page) of the combined block/page address as the
>> FPAR component, rather than considering the actual block size.
> Looks like this patch depends on the previous white-space clean-up patch
> - could you please refactor it (and 3/3 too) and resend?
Ok and I am going to add another new patch before 3/3.

-LiuShuo
> Artem.
>
>
