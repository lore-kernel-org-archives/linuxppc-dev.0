Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ED6A0DDE01
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 19:31:17 +1000 (EST)
Date: Mon, 28 Apr 2008 11:30:52 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Linux I2C <i2c@lm-sensors.org>
Subject: [PATCH 0/2] i2c: Add support for device alias names
Message-ID: <20080428113052.6d024bda@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Laurent, Sievers <kay.sievers@vrfy.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mundt <lethal@linux-sh.org>, Scott Wood <scottwood@freescale.com>, Kay
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

This is an updated, minimal patchset to add support for device alias
names to the i2c subsystem. It is based on earlier work by Jon Smirl,
Jochen Friedrich and myself.

For 2.6.26-rc1 I'll only attempt to push the first two patches: the one
adding the support for alias names and the one converting the drivers
to make use of it. I've even excluded most of the video drivers from
this patch, as they are a bit more difficult to deal with and I don't
want to break them for rc1. This will come later, together with the
patch removing the old device/driver matching scheme.

I've fixed a number of bugs since the previous iteration, and added a
few missing chunks as well. I hope I caught all the pieces this time
but that's hard to tell given that much of the changes are in arch code
I can't even build. So I would like everyone interested in these two
patches getting in 2.6.26-rc1 to give them good testing on as many
systems as possible, and report to me, ideally by the end of the day.
Sorry for the short notice, but I did my best with the little spare
time I had.

Note that there are RTC patches pending for upstream merge, which will
conflict with my patches. Andrew Morton should push them to Linus
today, so that I can rebase my patches before I send them to Linus
(tomorrow). The current versions of the patches apply on top of
2.6.26-git11.

Thanks,
-- 
Jean Delvare
