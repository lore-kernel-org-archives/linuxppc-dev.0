Return-Path: <linda.zhangwei@gmail.com>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.179])
	by ozlabs.org (Postfix) with ESMTP id A2774DDDF5
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2007 02:06:46 +1100 (EST)
Received: by el-out-1112.google.com with SMTP id r27so103587ele
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 07:06:45 -0800 (PST)
Message-ID: <4b7912400711140706i3c96456bua42dc01c6cb5467b@mail.gmail.com>
Date: Wed, 14 Nov 2007 15:06:42 +0000
From: "zhangwei zhang" <linda.zhangwei@gmail.com>
To: info@denx.de, linuxppc-embedded@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: about uImage-DENX-v2.6.14 config
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello, I have a problem when using linux-2.6.14(download from
ftp.denx.de) for RTAI on ppc440EP. I use the ELDK4.1 and when boot the
uImage I compiled , I always have the problem as following:

## Booting image at 00500000 ...
   Image Name:   Linux-2.6.14
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1155686 Bytes =  1.1 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK

then it stopped . I am afraid that maybe the problem comes from the
config. I have ever use the uImage-DENX-v2.6.14 you offered in
ftp.denx.de/pub/linux/amcc/image/yosemite/ and it works. So can you
send me a config file for 2.6.14 to me? Thank you.

Best wishes
kyla
