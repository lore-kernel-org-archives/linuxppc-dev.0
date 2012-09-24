Return-Path: <B04825@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe006.messaging.microsoft.com [213.199.154.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3AFF52C0085
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2012 00:38:46 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 1/2] mmc: Move mmc_delay() to include/linux/mmc/core.h
Date: Mon, 24 Sep 2012 14:38:34 +0000
Message-ID: <6AE080B68D46FC4BA2D2769E68D765B708090865@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1344637513-29383-1-git-send-email-Chunhe.Lan@freescale.com>
 <201209211233.54545.arnd@arndb.de>	<50607A5A.3060103@freescale.com>
 <201209241317.32425.arnd@arndb.de>
In-Reply-To: <201209241317.32425.arnd@arndb.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: Lan Chunhe-B25806 <B25806@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Gala Kumar-B11780 <B11780@freescale.com>, "cjb@laptop.org" <cjb@laptop.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 24, 2012 at 8:17 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>
>> static inline void mmc_delay(unsigned int ms)
>> {
>>           msleep(ms);
>> }
>
> That would be my preferred choice, unless someone has specific issues wit=
h this.

If we're going to do that, then just get rid of mmc_delay and replace
all calls to it with msleep().  Why bother with the inline function?
There's nothing really MMC-specific about it.

--=20
Timur Tabi
Linux kernel developer at Freescale=
