Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 9E2E8DDDFA
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 18:47:50 +1000 (EST)
Message-ID: <46555294.6040104@ru.mvista.com>
Date: Thu, 24 May 2007 12:53:40 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Xilinx git tree at source.mvista.com
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

My Xilinx Virtex Development tree is now alive again.

Please use the dev branch (master is just the ko copy):
http://source.mvista.com/git/gitweb.cgi?p=linux-xilinx-26.git;a=shortlog;h=dev
Currently it has a patch to enable the framebuffer
on ML403 and ML300 plus TEMAC driver that uses
the PHY lib (FIFO mode support only).
The TEMAC driver is work in progress.
In the queue are SGDMA TEMAC support, and SPI driver
(master only).

My concern is that the TEMAC driver uses the "level 1 drivers" from EDK 9.1.
The comments / opinions on how to get this driver (not the current incomplete
version of course) accepted into the ko tree are very welcomed.

I am not quite satisfied with how the current git repository
is structured, and may rework it completely later.

Thanks,
Andrei
