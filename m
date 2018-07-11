Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Qft404YCzF35M
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2018 23:24:11 +1000 (AEST)
In-Reply-To: <20180618095653.1538471-1-arnd@arndb.de>
To: Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc: xmon: use ktime_get_coarse_boottime64
Message-Id: <41Qft238h0zB4MX@ozlabs.org>
Date: Wed, 11 Jul 2018 23:24:10 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-06-18 at 09:56:24 UTC, Arnd Bergmann wrote:
> get_monotonic_boottime() is deprecated, and may not be safe to call in
> every context, as it has to read a hardware clocksource.
> 
> This changes xmon to print the time using ktime_get_coarse_boottime64()
> instead, which avoids the old timespec type and the HW access.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f6bd74fa084eb9ad573ffbb236a095

cheers
