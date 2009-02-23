Return-Path: <DusharaJ@optiscan.com>
Received: from mail.optiscan.com (mail.optiscan.com [203.26.112.1])
	by ozlabs.org (Postfix) with ESMTP id D15D3DDF6F
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Feb 2009 10:31:40 +1100 (EST)
From: Dushara Jayasinghe <DusharaJ@optiscan.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Date: Tue, 24 Feb 2009 10:31:37 +1100
Subject: soc vs localbus for flash in device tree
Message-ID: <DE0CCFFBFF707949BEABD4537A14ACBA0C04B40559@mailsvr>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I'm working on the kernel version Linux-2.6.29-rc5 with U-Boot 1.2.0-g88e21=
e7b-dirty.

Does the flash node HAVE to be within a localbus node or can it reside with=
in the soc node? I've been basing my work on mpc834x_mds.dts
And hence haven't defined a localbus node.

BTW is there a way to search the ML archive? Currently I browse each month =
to search for prior postings.

Thanks
D
