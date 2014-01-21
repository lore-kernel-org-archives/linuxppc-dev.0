Return-Path: <geoff@infradead.org>
Received: from merlin.infradead.org (unknown [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 66A9C2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jan 2014 10:48:23 +1100 (EST)
Message-ID: <1390348085.5027.18.camel@smoke>
Subject: Re: [PATCH 10/73] powerpc: use device_initcall for registering rtc
 devices
From: Geoff Levand <geoff@infradead.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Tue, 21 Jan 2014 15:48:05 -0800
In-Reply-To: <1390339396-3479-11-git-send-email-paul.gortmaker@windriver.com>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>
 <1390339396-3479-11-git-send-email-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Paul,

On Tue, 2014-01-21 at 16:22 -0500, Paul Gortmaker wrote:
> Currently these two RTC devices are in core platform code
> where it is not possible for them to be modular.  It will
> never be modular, so using module_init as an alias for
> __initcall can be somewhat misleading.
> 
>  arch/powerpc/kernel/time.c        | 2 +-
>  arch/powerpc/platforms/ps3/time.c | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)

I tested the PS3 part of this patch and it seems to work OK.

Acked-by: Geoff Levand <geoff@infradead.org>
