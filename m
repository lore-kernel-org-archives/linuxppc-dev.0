Return-Path: <olaf@ibook.aepfle.de>
Received: from natklopstock.rzone.de (natklopstock.rzone.de [81.169.145.174])
	by ozlabs.org (Postfix) with ESMTP id 51CFD67A33
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Sep 2006 16:41:20 +1000 (EST)
Received: from ibook.aepfle.de (p5493CA40.dip.t-dialin.net [84.147.202.64])
	by post.webmailer.de (8.13.6/8.13.6) with ESMTP id k8O6fCRX029632
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Sep 2006 08:41:13 +0200 (MEST)
Date: Sun, 24 Sep 2006 08:40:08 +0200
From: Olaf Hering <olaf@aepfle.de>
To: linuxppc-dev@ozlabs.org
Subject: AC power not detected if no battery present
Message-ID: <20060924064008.GA7925@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


PMU_PWR_AC_PRESENT in pmu_power_flags is never set if booted without
battery. This leads to 'AC Power' == 0 in /proc/pmu/info.
How can this be fixed properly?
