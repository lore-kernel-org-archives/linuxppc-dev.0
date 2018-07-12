Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41R5bp0Z74zF35b
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2018 16:28:22 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Cc: y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
 Balbir Singh <bsingharora@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, Breno Leitao <leitao@debian.org>,
 Mathieu Malaterre <malat@debian.org>, Yisheng Xie <xieyisheng1@huawei.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RESEND] powerpc: xmon: use ktime_get_coarse_boottime64
In-Reply-To: <20180711125338.1365368-1-arnd@arndb.de>
References: <20180711125338.1365368-1-arnd@arndb.de>
Date: Thu, 12 Jul 2018 16:28:18 +1000
Message-ID: <877em17yt9.fsf@concordia.ellerman.id.au>
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

Arnd Bergmann <arnd@arndb.de> writes:

> get_monotonic_boottime() is deprecated, and may not be safe to call in
> every context, as it has to read a hardware clocksource.
>
> This changes xmon to print the time using ktime_get_coarse_boottime64()
> instead, which avoids the old timespec type and the HW access.
>
> Acked-by: Balbir Singh <bsingharora@gmail.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Originally sent Jun 18, but this hasn't appeared in linux-next yet.
>
> Resending to make sure this is still on the radar. Please apply
> to the powerpc git for 4.19

I had applied it but forgot to push.

Should be there today.

cheers
