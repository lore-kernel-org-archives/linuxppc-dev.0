Return-Path: <SRS0+6740c57f952c672cdc2a+1672+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5DDB7DDF74
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Mar 2008 06:35:14 +1100 (EST)
Subject: Re: [PATCH] windfarm: add PowerMac 12,1 support
From: David Woodhouse <dwmw2@infradead.org>
To: =?ISO-8859-1?Q?=C9tienne?= Bersac <bersace03@gmail.com>
In-Reply-To: <1201348525.6859.1.camel@thilivren>
References: <1201348525.6859.1.camel@thilivren>
Content-Type: text/plain; charset=UTF-8
Date: Sat, 22 Mar 2008 19:35:08 +0000
Message-Id: <1206214508.9540.89.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2008-01-26 at 12:55 +0100, Étienne Bersac wrote:
> From: Étienne Bersac <bersace@gmail.com>
> 
> Implement a new driver named windfarm_pm121 which drive fans on PowerMac
> 12,1 machine : iMac G5 iSight (rev C) 17" and 20". It's based on
> windfarm_pm81 driver from Benjamin Herrenschmidt.

Is it just coincidence, or does it only seem to stop the fans when I
cat /sys/devices/platform/windfarm.0/cpu-temp ? 

-- 
dwmw2
