Return-Path: <akira2.iguchi@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 791B8DDE20
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 20:28:35 +1100 (EST)
Received: from tsb-wall.toshiba.co.jp ([133.199.160.134])
	by inet-tsb5.toshiba.co.jp  with ESMTP id l0B9SVqg003899
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 18:28:31 +0900 (JST)
Received: (from root@localhost) by tsb-wall.toshiba.co.jp  id l0B9SWxi019839
	for linuxppc-dev@ozlabs.org; Thu, 11 Jan 2007 18:28:32 +0900 (JST)
Received: from mx12.toshiba.co.jp (localhost [127.0.0.1])
	by ovp1.toshiba.co.jp  with ESMTP id l0B9SVND001429
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 18:28:31 +0900 (JST)
Message-Id: <200701110928.l0B9SUri015056@toshiba.co.jp>
MIME-Version: 1.0
Date: Thu, 11 Jan 2007 18:30:55 +0900
From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: (Your message of "Thu, 11 Jan 2007 10:08:34 +0100")
	<200701111008.34866.arnd@arndb.de>
References: <200701110853.l0B8rtGK009404@toshiba.co.jp>
	<200701111008.34866.arnd@arndb.de>
Subject: Re: [PATCH 2/2] drivers/ata: export some static functions in
	libata-core.c
Cc: linux-ide@vger.kernel.org, paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Arnd-san.

Thank you for checking our patches.

>On Thursday 11 January 2007 09:56, Akira Iguchi wrote:
>> This patch modifies some static functions in libata-core.c
>> and libata.h to use them in ata_scc.c.
>
>Exporting new symbols needs some explanation here about why they
>should now be global for ata_scc while the existing drivers
>did not need them. Since the patch otherwise only moves stuff
>around as needed, I assume it's good.

I thought it was better to use common functions as far as possible.
But if it is preferable to copy them in ata_scc.c, I will do so.

Best regards,
Akira Iguchi
