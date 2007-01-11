Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id CD1E4DDE2B
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 20:08:47 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: Re: [PATCH 2/2] drivers/ata: export some static functions in
	libata-core.c
Date: Thu, 11 Jan 2007 10:08:34 +0100
References: <200701110853.l0B8rtGK009404@toshiba.co.jp>
In-Reply-To: <200701110853.l0B8rtGK009404@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200701111008.34866.arnd@arndb.de>
Cc: linux-ide@vger.kernel.org, paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 11 January 2007 09:56, Akira Iguchi wrote:
> This patch modifies some static functions in libata-core.c
> and libata.h to use them in ata_scc.c.

Exporting new symbols needs some explanation here about why they
should now be global for ata_scc while the existing drivers
did not need them. Since the patch otherwise only moves stuff
around as needed, I assume it's good.

	Arnd <><
