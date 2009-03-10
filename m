Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from SG2EHSOBE003.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80]) by ozlabs.org (Postfix) with ESMTP id D7A5FDE052
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 03:20:44 +1100 (EST)
Message-ID: <49B692EC.1020505@am.sony.com>
Date: Tue, 10 Mar 2009 09:18:52 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH 7/7] powerpc/ps3: Add rtc-ps3
References: <1236605183-22718-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-6-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-7-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-8-git-send-email-Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1236605183-22718-8-git-send-email-Geert.Uytterhoeven@sonycom.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linux-m68k@vger.kernel.org,
	Alessandro Zummo <alessandro.zummo@towertech.it>,
	rtc-linux@googlegroups.com, linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kyle McMartin <kyle@mcmartin.ca>,
	linuxppc-dev@ozlabs.org, Paul Mundt <lethal@linux-sh.org>,
	Dann Frazier <dannf@dannf.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 03/09/2009 06:26 AM, Geert Uytterhoeven wrote:
> Create a real RTC driver for PS3, and unhook the deprecated
> ppc_md.[gs]et_rtc_time.
> 
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> Cc: Geoff Levand <geoffrey.levand@am.sony.com>
> ---
>  arch/powerpc/include/asm/ps3.h        |    3 +
>  arch/powerpc/platforms/ps3/os-area.c  |    2 +
>  arch/powerpc/platforms/ps3/platform.h |    2 -
>  arch/powerpc/platforms/ps3/setup.c    |    2 -
>  arch/powerpc/platforms/ps3/time.c     |   26 ++++-----
>  drivers/rtc/Kconfig                   |    9 +++
>  drivers/rtc/Makefile                  |    1 +
>  drivers/rtc/rtc-ps3.c                 |  105 +++++++++++++++++++++++++++++++++
>  8 files changed, 132 insertions(+), 18 deletions(-)
>  create mode 100644 drivers/rtc/rtc-ps3.c

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
