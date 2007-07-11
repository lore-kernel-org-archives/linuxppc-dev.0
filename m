Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 1369ADDE25
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 07:02:32 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC][PATCH 5/8] Fix 4xx build
Date: Wed, 11 Jul 2007 23:00:24 +0200
References: <1184161957.32199.52.camel@weaponx.rchland.ibm.com>
	<1184162326.32199.63.camel@weaponx.rchland.ibm.com>
In-Reply-To: <1184162326.32199.63.camel@weaponx.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707112300.25128.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 11 July 2007, Josh Boyer wrote:
> -#if defined(CONFIG_8xx) || defined(CONFIG_40x)
> +#if defined(CONFIG_8xx)
> =A0EXPORT_SYMBOL(__res);
> =A0#endif


Actually, __res also isn't defined on 8xx, so the export
should probably go away entirely.=20

	Arnd <><
