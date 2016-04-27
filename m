Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvx0Z1DYXzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 20:24:46 +1000 (AEST)
Date: Wed, 27 Apr 2016 12:05:23 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, tony.luck@intel.com,
 geert@linux-m68k.org, jejb@parisc-linux.org, deller@gmx.de,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dalias@libc.org,
 dhowells@redhat.com, yasutake.koichi@jp.panasonic.com, rth@twiddle.net,
 ink@jurassic.park.msu.ru, linux-alpha@vger.kernel.org, x86@kernel.org,
 a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
 linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-sh@vger.kernel.org, rtc-linux@googlegroups.com,
 linux-arch@vger.kernel.org
Subject: Re: [PATCH 2/8] char/rtc: legacy RTC is no longer supported on x86
In-Reply-To: <1461707052-1337718-3-git-send-email-arnd@arndb.de>
Message-ID: <alpine.DEB.2.11.1604271205100.3941@nanos>
References: <1461707052-1337718-1-git-send-email-arnd@arndb.de>
 <1461707052-1337718-3-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 26 Apr 2016, Arnd Bergmann wrote:

> Commit 3195ef59cb42 ("x86: Do full rtc synchronization with ntp") had
> the side-effect of unconditionally enabling the RTC_LIB symbol on x86,
> which in turn disables the selection of the CONFIG_RTC and
> CONFIG_GEN_RTC drivers that contain a two older implementations of
> the CONFIG_RTC_DRV_CMOS driver.
> 
> This removes x86 from the list.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
