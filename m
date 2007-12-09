Return-Path: <jonsmirl@gmail.com>
Received: from vms040pub.verizon.net (vms040pub.verizon.net [206.46.252.40])
	by ozlabs.org (Postfix) with ESMTP id 6AA01DE027
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 10:37:39 +1100 (EST)
Received: from terra.home ([96.233.72.204])
	by vms040.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01
	(built Apr
	3 2006)) with ESMTPA id <0JST00AG32YY260V@vms040.mailsrvcs.net> for
	linuxppc-dev@ozlabs.org; Sun, 09 Dec 2007 17:37:46 -0600 (CST)
Date: Sun, 09 Dec 2007 18:36:48 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH 0/4] Series to add device tree naming to i2c
To: i2c@lm-sensors.org, linuxppc-dev@ozlabs.org
Message-id: <20071209233648.2327.14584.stgit@terra.home>
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

New verision, addresses whitespace issues

The following series implements standard linux module aliasing for i2c modules
It then converts the mpc i2c driver from being a platform driver to an open
firmware one. I2C device names are picked up from the device tree. Module
aliasing is used to translate from device tree names into to linux kernel
names. Several i2c drivers are updated to use the new aliasing. 

--
Jon Smirl
jonsmirl@gmail.com 
