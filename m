Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5E58EB6FE0
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Jun 2011 15:08:33 +1000 (EST)
Subject: Re: [PATCH] Fix build warning of the defconfigs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wanlong Gao <wanlong.gao@gmail.com>
In-Reply-To: <1306945763-6583-1-git-send-email-wanlong.gao@gmail.com>
References: <1306945763-6583-1-git-send-email-wanlong.gao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 09 Jun 2011 15:06:28 +1000
Message-ID: <1307595988.2874.266.camel@pasglop>
Mime-Version: 1.0
Cc: linux-mips@linux-mips.org, david.woodhouse@intel.com,
	linux-sh@vger.kernel.org, paulus@samba.org, gxt@mprc.pku.edu.cn,
	sam@ravnborg.org, linux@arm.linux.org.uk,
	manuel.lauss@googlemail.com, rientjes@google.com, mingo@elte.hu,
	vapier@gentoo.org, arnd@arndb.de, u.kleine-koenig@pengutronix.de,
	anton@samba.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, ralf@linux-mips.org,
	lethal@linux-sh.org, uclinux-dist-devel@blackfin.uclinux.org,
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

On Thu, 2011-06-02 at 00:29 +0800, Wanlong Gao wrote:
> RTC_CLASS is changed to bool.
> So value 'm' is invalid.
> 
> Signed-off-by: Wanlong Gao <wanlong.gao@gmail.com>
> ---

For powerpc:

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Thanks !

Ben.
