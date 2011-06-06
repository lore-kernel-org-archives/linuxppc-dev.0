Return-Path: <Hans-Christian.Egtvedt@atmel.com>
Received: from sjogate2.atmel.com (newsmtp5.atmel.com [204.2.163.5])
	by ozlabs.org (Postfix) with ESMTP id 6025EB6FBB
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  6 Jun 2011 17:09:12 +1000 (EST)
Subject: Re: [PATCH] Fix build warning of the defconfigs
From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
To: Wanlong Gao <wanlong.gao@gmail.com>
In-Reply-To: <1306945763-6583-1-git-send-email-wanlong.gao@gmail.com>
References: <1306945763-6583-1-git-send-email-wanlong.gao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 06 Jun 2011 08:24:45 +0200
Message-ID: <1307341485.3104.0.camel@hcegtvedt.norway.atmel.com>
Mime-Version: 1.0
Cc: linux-mips@linux-mips.org, david.woodhouse@intel.com,
	linux-sh@vger.kernel.org, paulus@samba.org, gxt@mprc.pku.edu.cn,
	sam@ravnborg.org, linux@arm.linux.org.uk,
	manuel.lauss@googlemail.com, rientjes@google.com, mingo@elte.hu,
	vapier@gentoo.org, arnd@arndb.de, u.kleine-koenig@pengutronix.de,
	anton@samba.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, ralf@linux-mips.org,
	lethal@linux-sh.org, uclinux-dist-devel@blackfin.uclinux.org,
	akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-06-02 at 00:29 +0800, Wanlong Gao wrote:
> RTC_CLASS is changed to bool.
> So value 'm' is invalid.
> 
> Signed-off-by: Wanlong Gao <wanlong.gao@gmail.com>

<snipp>

>  arch/avr32/configs/atngw100_mrmt_defconfig |    2 +-
>

For the AVR32 related changes.

Acked-by: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>

<snipp>

-- 
Hans-Christian Egtvedt
