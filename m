Return-Path: <wangyijing@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B89732C0086
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jan 2014 18:24:18 +1100 (EST)
From: Yijing Wang <wangyijing@huawei.com>
To: John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 1/2] clocksource: Remove outdated comments
Date: Thu, 23 Jan 2014 15:12:27 +0800
Message-ID: <1390461147-36256-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-mips@linux-mips.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Kevin Hilman <khilman@deeprootsystems.com>, linux@lists.openrisc.net,
 Sekhar Nori <nsekhar@ti.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Yijing
 Wang <wangyijing@huawei.com>, Daniel Walker <dwalker@fifo99.com>,
 Hans-Christian Egtvedt <egtvedt@samfundet.no>, Jonas Bonn <jonas@southpole.se>,
 Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>,
 Richard Weinberger <richard@nod.at>, x86@kernel.org,
 Tony Lindgren <tony@atomide.com>, Ingo
 Molnar <mingo@redhat.com>, linux-arm-msm@vger.kernel.org,
 David Brown <davidb@codeaurora.org>,
 Haavard Skinnemoen <hskinnemoen@gmail.com>, Mike Frysinger <vapier@gentoo.org>,
 user-mode-linux-devel@lists.sourceforge.net,
 Nicolas Ferre <nicolas.ferre@atmel.com>, Jeff Dike <jdike@addtoit.com>,
 Barry Song <baohua@kernel.org>, linux-samsung-soc@vger.kernel.org,
 user-mode-linux-user@lists.sourceforge.net, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 davinci-linux-open-source@linux.davincidsp.com,
 Michal Simek <monstr@monstr.eu>, Jim Cromie <jim.cromie@gmail.com>,
 microblaze-uclinux@itee.uq.edu.au, Hanjun Guo <guohanjun@huawei.com>,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 Tony Prisk <linux@prisktech.co.nz>, Bryan Huntsman <bryanh@codeaurora.org>,
 uclinux-dist-devel@blackfin.uclinux.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

clocksource_register() and __clocksource_register_scale()
always return 0, so the comment is just pointless, it's
outdated, remove it.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 kernel/time/clocksource.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index ba3e502..9951575 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -779,8 +779,6 @@ EXPORT_SYMBOL_GPL(__clocksource_updatefreq_scale);
  * @scale:	Scale factor multiplied against freq to get clocksource hz
  * @freq:	clocksource frequency (cycles per second) divided by scale
  *
- * Returns -EBUSY if registration fails, zero otherwise.
- *
  * This *SHOULD NOT* be called directly! Please use the
  * clocksource_register_hz() or clocksource_register_khz helper functions.
  */
@@ -805,7 +803,6 @@ EXPORT_SYMBOL_GPL(__clocksource_register_scale);
  * clocksource_register - Used to install new clocksources
  * @cs:		clocksource to be registered
  *
- * Returns -EBUSY if registration fails, zero otherwise.
  */
 int clocksource_register(struct clocksource *cs)
 {
-- 
1.7.1
