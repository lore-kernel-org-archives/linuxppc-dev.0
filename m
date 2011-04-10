Return-Path: <ukl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 40E18B6F1C
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Apr 2011 04:13:59 +1000 (EST)
Date: Sun, 10 Apr 2011 20:12:38 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: wanlong.gao@gmail.com
Subject: Re: [PATCH] fix build warnings on defconfigs
Message-ID: <20110410181238.GE18601@pengutronix.de>
References: <1302375858-11253-1-git-send-email-wanlong.gao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1302375858-11253-1-git-send-email-wanlong.gao@gmail.com>
Cc: linux-mips@linux-mips.org, david.woodhouse@intel.com, tony@atomide.com,
	nicolas.ferre@atmel.com, paulus@samba.org, eric@eukrea.com,
	sam@ravnborg.org, sfr@canb.auug.org.au, linux@arm.linux.org.uk,
	khilman@deeprootsystems.com, manuel.lauss@googlemail.com,
	rientjes@google.com, mingo@elte.hu, anton@samba.org,
	ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org,
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

On Sun, Apr 10, 2011 at 03:04:18AM +0800, wanlong.gao@gmail.com wrote:
> From: Wanlong Gao <wanlong.gao@gmail.com>
> 
> Change the BT_L2CAP and BT_SCO defconfigs from 'm' to 'y',
> since BT_L2CAP and BT_SCO had changed to bool configs.
Pointing out the commit that changed these two in the commit log would
be nice. Something like:

	The BT_L2CAP and BT_SCO configs are bool since

		6427451 (Bluetooth: Merge L2CAP and SCO modules into bluetooth.ko)

	. So change all defconfigs from =m to =y.

Other than that
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
