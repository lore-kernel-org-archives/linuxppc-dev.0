Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id CBA1BDDDEB
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 18:39:10 +1000 (EST)
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 14 Sep 2007 10:39:07 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Message-ID: <20070914083907.321820@gmx.net>
MIME-Version: 1.0
Subject: RTC class drivers and powerpc arch
To: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Since todc was removed from arch/powerpc I wonder how to use the rtc-cmos
RTC class driver for my AmigaOne with its VIA southbridge. Do I have to
define a platform device and the get/set_rtc_time hook functions or can
the driver probe for and access the hardware automatically, if there's a
device node for the RTC in the device tree?

Thanks!

regards,

Gerhard
-- 
GMX FreeMail: 1 GB Postfach, 5 E-Mail-Adressen, 10 Free SMS.
Alle Infos und kostenlose Anmeldung: http://www.gmx.net/de/go/freemail
