Return-Path: <sr@denx.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.188])
	by ozlabs.org (Postfix) with ESMTP id 6D8F0DDF72
	for <linuxppc-dev@ozlabs.org>; Tue,  1 May 2007 00:41:28 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: netdev@vger.kernel.org
Subject: IEEE1588 Precision Time Protocol (PTP) driver for AMCC 405EZ
Date: Mon, 30 Apr 2007 16:41:32 +0200
MIME-Version: 1.0
Message-Id: <200704301641.32686.sr@denx.de>
Content-Type: text/plain;
  charset="us-ascii"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

I'm in the stage of integrating an IEEE1588 PTP driver for the AMCC 405EZ PPC 
and looking for the correct location to place this driver in the Linux source 
tree. The driver is a character-driver that enables the user space 
applications to configure the time stamping unit and to read/write the 
timestamps.

Is "drivers/net/ptp" or "drivers/net/ieee1588" a good solution? Or should it 
go to "drivers/char/ptp" because of the chrdev nature of the driver?

Any suggestions welcome (could be that I missed an already existing example).

Best regards,
Stefan
