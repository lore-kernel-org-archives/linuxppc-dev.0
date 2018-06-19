Return-Path: <bsingharora@gmail.com>
Received: from mail-ua0-x244.google.com (mail-ua0-x244.google.com
 [IPv6:2607:f8b0:400c:c08::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 418rZq2tZXzF0Pd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 11:53:07 +1000 (AEST)
Received: by mail-ua0-x244.google.com with SMTP id c23-v6so12012560uan.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2018 18:53:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180618095653.1538471-1-arnd@arndb.de>
References: <20180618095653.1538471-1-arnd@arndb.de>
From: Balbir Singh <bsingharora@gmail.com>
Date: Tue, 19 Jun 2018 11:53:03 +1000
Message-ID: <CAKTCnzmTV6g8NhkUv1sj=iMQemOTZK7eN_59dqjbpFnrGdsk2A@mail.gmail.com>
Subject: Re: [PATCH] powerpc: xmon: use ktime_get_coarse_boottime64
To: Arnd Bergmann <arnd@arndb.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, y2038@lists.linaro.org,
 Nicholas Piggin <npiggin@gmail.com>, Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 18, 2018 at 7:56 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> get_monotonic_boottime() is deprecated, and may not be safe to call in
> every context, as it has to read a hardware clocksource.
>
> This changes xmon to print the time using ktime_get_coarse_boottime64()
> instead, which avoids the old timespec type and the HW access.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Looks good to me!

Acked-by: Balbir Singh <bsingharora@gmail.com>

Balbir Singh
