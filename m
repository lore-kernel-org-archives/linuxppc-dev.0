Return-Path: <jonsmirl@gmail.com>
Received: from vms040pub.verizon.net (vms040pub.verizon.net [206.46.252.40])
	by ozlabs.org (Postfix) with ESMTP id 40940DDEE6
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 01:43:17 +1100 (EST)
Received: from terra.home ([96.233.72.204])
	by vms040.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01
	(built Apr
	3 2006)) with ESMTPA id <0JVC00799ZLIOWH2@vms040.mailsrvcs.net> for
	linuxppc-dev@ozlabs.org; Mon, 28 Jan 2008 08:44:07 -0600 (CST)
Date: Mon, 28 Jan 2008 09:42:02 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH 0/3] Implement device tree based i2c module loading on mpc5200
	powerpc
To: i2c@lm-sensors.org, linuxppc-dev@ozlabs.org
Message-id: <20080128144202.8410.14647.stgit@terra.home>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These are the final three patches in the series implementing device tree directed loading of i2c modules on mpc5200 powerpc. These patches have been posted multiple times. This revision implements a few minor changes suggested in the last two weeks.

--
Jon Smirl
jonsmirl@gmail.com 
