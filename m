Return-Path: <to-fleischer@t-online.de>
Received: from mailout08.t-online.de (mailout08.t-online.de [194.25.134.20])
	by ozlabs.org (Postfix) with ESMTP id F3292B7CE6
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 26 Jan 2010 06:22:57 +1100 (EST)
From: Torsten Fleischer <to-fleischer@t-online.de>
Subject: spi_mpc8xxx: Setting cs_change at the last transfer of a message
Date: Mon, 25 Jan 2010 17:21:41 +0100
MIME-Version: 1.0
To: spi-devel-general@lists.sourceforge.net
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201001251721.41544.to-fleischer@t-online.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As stated in spi.h (at struct spi_transfer) the driver can keep the chip 
select of the last device active if cs_change is set at the last transfer of a 
message.
The spi_mpc8xxx driver always deactivates the chip select after completing the 
message regardless of cs_change is set or not.

I'd like to patch this. But before doing that I'd like to learn if there are 
any known use cases where the above described behavior of the driver is 
needed.


Thanks
Torsten
