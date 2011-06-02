Return-Path: <lethal@linux-sh.org>
Received: from linux-sh.org (linux-sh.org [111.68.239.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9858BB6F9A
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jun 2011 15:26:20 +1000 (EST)
Date: Thu, 2 Jun 2011 14:24:52 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Wanlong Gao <wanlong.gao@gmail.com>
Subject: Re: [PATCH] Fix build warning of the defconfigs
Message-ID: <20110602052452.GA6087@linux-sh.org>
References: <1306945763-6583-1-git-send-email-wanlong.gao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1306945763-6583-1-git-send-email-wanlong.gao@gmail.com>
Cc: linux-mips@linux-mips.org, david.woodhouse@intel.com,
	linux-sh@vger.kernel.org, paulus@samba.org, gxt@mprc.pku.edu.cn,
	sam@ravnborg.org, linux@arm.linux.org.uk,
	manuel.lauss@googlemail.com, rientjes@google.com, mingo@elte.hu,
	vapier@gentoo.org, arnd@arndb.de, u.kleine-koenig@pengutronix.de,
	anton@samba.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, ralf@linux-mips.org,
	uclinux-dist-devel@blackfin.uclinux.org,
	akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
	hans-christian.egtvedt@atmel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 02, 2011 at 12:29:23AM +0800, Wanlong Gao wrote:
> RTC_CLASS is changed to bool.
> So value 'm' is invalid.
> 
> Signed-off-by: Wanlong Gao <wanlong.gao@gmail.com>

>  arch/sh/configs/titan_defconfig            |    2 +-

Acked-by: Paul Mundt <lethal@linux-sh.org>
