Return-Path: <grinberg@compulab.co.il>
Received: from softlayer.compulab.co.il
	(50.23.254.54-static.reverse.softlayer.com [50.23.254.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BA70CB6F08
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Apr 2011 17:01:16 +1000 (EST)
Message-ID: <4DA29B75.4090401@compulab.co.il>
Date: Mon, 11 Apr 2011 09:11:01 +0300
From: Igor Grinberg <grinberg@compulab.co.il>
MIME-Version: 1.0
To: wanlong.gao@gmail.com
Subject: Re: [PATCH] fix build warnings on defconfigs
References: <1302375858-11253-1-git-send-email-wanlong.gao@gmail.com>
In-Reply-To: <1302375858-11253-1-git-send-email-wanlong.gao@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-mips@linux-mips.org, david.woodhouse@intel.com, tony@atomide.com,
	nicolas.ferre@atmel.com, paulus@samba.org, eric@eukrea.com,
	sam@ravnborg.org, sfr@canb.auug.org.au, linux@arm.linux.org.uk,
	khilman@deeprootsystems.com, manuel.lauss@googlemail.com,
	u.kleine-koenig@pengutronix.de, mingo@elte.hu,
	rientjes@google.com, anton@samba.org, ben-linux@fluff.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, ralf@linux-mips.org,
	santosh.shilimkar@ti.com, akpm@linux-foundation.org,
	linuxppc-dev@lists.ozlabs.org, hans-christian.egtvedt@atmel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/09/11 22:04, wanlong.gao@gmail.com wrote:

> From: Wanlong Gao <wanlong.gao@gmail.com>
>
> Change the BT_L2CAP and BT_SCO defconfigs from 'm' to 'y',
> since BT_L2CAP and BT_SCO had changed to bool configs.
>
> Signed-off-by: Wanlong Gao <wanlong.gao@gmail.com>
> ---

For:

>  arch/arm/configs/cm_x2xx_defconfig         |    4 ++--
>  arch/arm/configs/cm_x300_defconfig         |    4 ++--
>  arch/arm/configs/em_x270_defconfig         |    4 ++--

Acked-by: Igor Grinberg <grinberg@compulab.co.il>

-- 
Regards,
Igor.
