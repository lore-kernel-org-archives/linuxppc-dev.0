Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc3-s3.bay0.hotmail.com (bay0-omc3-s3.bay0.hotmail.com
	[65.54.246.203]) by ozlabs.org (Postfix) with ESMTP id 895ED67B5F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Sep 2006 23:25:02 +1000 (EST)
Message-ID: <BAY110-F3134BF8AE457F9613DCB68B21A0@phx.gbl>
From: "Ming Liu" <eemingliu@hotmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: flash operations in linux on ML403
Date: Wed, 27 Sep 2006 13:24:56 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear all,
Can anyone tell me, how to include the driver for flash chips on ML403 
board and make the flash chip a visible device which could be written or 
read in Linux 2.6? I notice that there is a item called "MTD" in the 
"device driver" in the kernel menuconfig. Is that the driver for the flash 
chip? And also how to make it visiable in /dev/ ? Thanks in advance for 
your telling.

Regards
Ming

_________________________________________________________________
与联机的朋友进行交流，请使用 MSN Messenger:  http://messenger.msn.com/cn  
