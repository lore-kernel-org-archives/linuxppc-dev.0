Return-Path: <surendra.yadav@softdel.com>
Received: from softdel.com (unknown [202.68.143.18])
	by ozlabs.org (Postfix) with ESMTP id 6F14967F33
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Aug 2005 23:36:18 +1000 (EST)
Received: from surendraw2k ([192.168.10.91]) by softdel.com ([192.168.10.4])
	with SMTP (MDaemon.PRO.v6.0.2.R)
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Aug 2005 18:49:57 +0530
From: "Surendra Yadav" <surendra.yadav@softdel.com>
To: <linuxppc-dev@ozlabs.org>
Date: Tue, 16 Aug 2005 19:04:54 +0530
Message-ID: <BPEMKMADCCCPHPEDDKOOMEHFCFAA.surendra.yadav@softdel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Framebuffer driver using SM501 hardware.
Reply-To: surendra.yadav@softdel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

I am writing framebuffer driver using SM501. This graphics driver chip can
drive CRT and TFT panel. I have written two seperate framebuffer driver, one
for CRT and one for TFT Panel.

But I am not able to test both the devices. Any one of them work at a time.
I have created two files /dev/fb0 and /dev/fb1. These two can be open
successfully and mmap is also successful from userspace. If I am trying to
write on fb0 and  fb1 with different data, they displayed on either CRT or
TFT panel.

Can any one help me How to test two different framebuffer devices?

Thanks.
