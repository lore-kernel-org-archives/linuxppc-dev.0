Return-Path: <JihuaC@aaesys.com>
Received: from aae-exchange.aaesys.com (mail.aaesys.com [67.131.247.41])
	by ozlabs.org (Postfix) with ESMTP id C3E142BDA2
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Sep 2004 09:03:59 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Fri, 24 Sep 2004 15:51:48 -0700
Message-ID: <92B7B15A1C9E564B94BEE09BA4E1E2A603FC57@aae-exchange.aaesys.com>
From: "Jihua Cheng" <JihuaC@aaesys.com>
To: <linuxppc-dev@ozlabs.org>
Subject: memory swapping question
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

I am new to linux kernel. Sorry for the following dumbing question:

I am writing a linux driver which provides write() for user application, =
under 2.4.20. The data from application will be written to hardware io =
ports, byte by byte. In my write() function, I use __copy_from_user() to =
copy data from user-mode to kernel-mode memory, then to read the =
kernel-mode memory and to output data to hardware io ports byte by byte. =
The write() does not return until all the data are outputed to hardware. =
However, I think the data copy from user-to kernel-mode wastes my time. =
In my Write() function, Could I read one byte(word) by one byte(word) =
from user-mode memory? and How?Do I have the memory swaping problem, =
under what situation?

Thanks so much for your kindly help.

Regards,

Charles
