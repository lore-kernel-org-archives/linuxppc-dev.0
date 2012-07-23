Return-Path: <wimvs@spo001.leaseweb.com>
Received: from spo001.leaseweb.com (ns1.pc-advies.be [83.149.101.17])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 882402C034A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 20:57:02 +1000 (EST)
Date: Mon, 23 Jul 2012 12:37:30 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 17/25] watchdog/mpc8xxx: add a const qualifier
Message-ID: <20120723103730.GL735@spo001.leaseweb.com>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1343034810-3386-18-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1343034810-3386-18-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: <wimvs@spo001.leaseweb.com>
Cc: linux-watchdog@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Rob Herring <rob.herring@calxeda.com>, kernel@pengutronix.de,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Uwe,

> From: Arnd Bergmann <arnd@arndb.de>
> 
> This prepares *of_device_id.data becoming const. Without this change
> the following warning would occur:
> 
> 	drivers/watchdog/mpc8xxx_wdt.c: In function 'mpc8xxx_wdt_probe':
> 	drivers/watchdog/mpc8xxx_wdt.c:203:11: warning: assignment discards 'const' qualifier from pointer target type [enabled by default]
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> [ukl: split Arnd's patch by driver and add changelog]
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Acked-by: Wim Van Sebroeck <wim@iguana.be>

Kind regards,
Wim.
