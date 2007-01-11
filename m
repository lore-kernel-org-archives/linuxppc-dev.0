Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 66C0DDDECC
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 00:06:05 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/2] drivers/ata: export some static functions in
	libata-core.c
Date: Thu, 11 Jan 2007 14:05:56 +0100
References: <200701110853.l0B8rtGK009404@toshiba.co.jp>
	<200701111008.34866.arnd@arndb.de>
	<200701110928.l0B9SUri015056@toshiba.co.jp>
In-Reply-To: <200701110928.l0B9SUri015056@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701111405.56575.arnd@arndb.de>
Cc: linux-ide@vger.kernel.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 11 January 2007 10:30, Akira Iguchi wrote:
> >Exporting new symbols needs some explanation here about why they
> >should now be global for ata_scc while the existing drivers
> >did not need them. Since the patch otherwise only moves stuff
> >around as needed, I assume it's good.
> 
> I thought it was better to use common functions as far as possible.
> But if it is preferable to copy them in ata_scc.c, I will do so.

To clarify my words here:

It is definitely better to use common functions or to modify the common
code rather than copy it.

This particular patch (2/2) only moves code around, so what I meant is
that I'm confident that it does not introduce bugs.

	Arnd <><
