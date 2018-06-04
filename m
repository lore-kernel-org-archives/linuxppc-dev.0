Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zxfk6xSTzF0dd
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 00:10:38 +1000 (AEST)
In-Reply-To: <20180423083642.2608886-1-arnd@arndb.de>
To: Arnd Bergmann <arnd@arndb.de>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: arnd@arndb.de, y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [1/5] powerpc: always enable RTC_LIB
Message-Id: <40zxfk06KTz9s1B@ozlabs.org>
Date: Tue,  5 Jun 2018 00:10:37 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-04-23 at 08:36:38 UTC, Arnd Bergmann wrote:
> In order to use the rtc_tm_to_time64() and rtc_time64_to_tm()
> helper functions in later patches, we have to ensure that
> CONFIG_RTC_LIB is always built-in.
> 
> Note that this symbol only controls a couple of helper functions,
> not the actual RTC subsystem, which remains optional and is
> enabled with CONFIG_RTC_CLASS.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6e8cef384a41882b2d4ec6992dd0d7

cheers
