Return-Path: <dedekind1@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 80A65B6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 10 Aug 2009 17:45:54 +1000 (EST)
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.nokia.com",
	Issuer "VeriSign Trust Network" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AA512DDD04
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2009 17:45:52 +1000 (EST)
Received: from mgw-mx09.nokia.com ([192.100.105.134])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id
	n7A7jQTM015930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2009 10:45:28 +0300
Subject: Re: [PATCH v2 0/6] Device table matching for SPI subsystem
From: Artem Bityutskiy <dedekind1@gmail.com>
To: avorontsov@ru.mvista.com
In-Reply-To: <20090731003957.GA23982@oksana.dev.rtsoft.ru>
References: <20090731003957.GA23982@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 10 Aug 2009 10:35:23 +0300
Message-Id: <1249889723.19638.13.camel@localhost>
Mime-Version: 1.0
Cc: Ben Dooks <ben@fluff.org>, David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Jean Delvare <khali@linux-fr.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Woodhouse <dwmw2@infradead.org>
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-07-31 at 04:39 +0400, Anton Vorontsov wrote:
> Andrew,
> 
> This new patch set overwrites following patches:
> 
>   hwmon-lm70-convert-to-device-table-matching.patch
>   hwmon-adxx-convert-to-device-table-matching.patch
>   spi-merge-probe-and-probe_id-callbacks.patch
>   spi-prefix-modalias-with-spi.patch
>   of-remove-stmm25p40-alias.patch
>   mtd-m25p80-convert-to-device-table-matching.patch
>   spi-add-support-for-device-table-matching.patch

Are you going to send v3 and address David's comments?
Do you want some of these patches to go via the MTD tree or
they better go as a series via some other tree?

-- 
Best Regards,
Artem Bityutskiy (Артём Битюцкий)
