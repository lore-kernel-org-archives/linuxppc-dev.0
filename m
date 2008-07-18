Return-Path: <vijay.t.nikam@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.234])
	by ozlabs.org (Postfix) with ESMTP id CB27DDDF39
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 18:28:06 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so194579rvb.9
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 01:28:05 -0700 (PDT)
Message-ID: <f234e2140807180128o13e4db1bt1db9b043c7859234@mail.gmail.com>
Date: Fri, 18 Jul 2008 13:58:05 +0530
From: "Vijay Nikam" <vijay.t.nikam@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Linux not booting on MPC8313ERDB
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

I am trying to port everything (u-boot-nand.bin, uImage(kernel), jffs2
and dtb) on NAND of MPC8313ERDB board ...

I loaded u-boot-nand.bin to boot the board from NAND and it is
successful ... but the problem is in loading kernel ... the kernel
version and location is detected properly and it starts loading it but
at mounting file system it gives Magic bit mask error and finally says
kernel panic and wait for reboot ...

Could any one please provide some information to proceed ... thank you

Kind Regards,
Vijay Nikam
