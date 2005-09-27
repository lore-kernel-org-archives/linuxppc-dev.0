Return-Path: <Baohua.WANG@alcatel-sbell.com.cn>
Received: from mail.alcatel-sbell.com.cn (nat1.alcatel-sbell.com.cn
	[202.96.203.177]) by ozlabs.org (Postfix) with ESMTP id 4477B683AE
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Sep 2005 11:29:14 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Date: Tue, 27 Sep 2005 09:28:57 +0800
Message-ID: <A9DE2BAF233E444FA9C5E77A5825A01E865070@ydmail.sbell.com.cn>
From: "FCG WANG Baohua" <Baohua.WANG@alcatel-sbell.com.cn>
To: <wd@denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: A question about the linux root file system (ext2)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear  Denk:
   I have a question when making a ext2 root file system for PPC82xx:
   1. How to execute the "/sbin/init" instead of "/bin/busybox" ?
        I tried it but it always said:
        "cannot find init ,pls use the init =3D ...."
        I want to use the ELDK 8xx file system instead of SELF little =
file system. After I convert it using genext2fs,
        it nerver find the "init " application, Why?

   2. How to fully use the size of the CF card ? That is, not limit the =
ext2 root file system file size,
       it can detect the size of CF card, and extend the free space to =
it.=20
   3. The genext2fs can only generate a vaild ext2 fs limit to 40Mb, if =
exceed it :
        the following message will be printed:
        "cannot find init ,pls use the init =3D ...."
       How to avoid it ?
  4. When I copy the gcc, g++, as files of  "8xx file system in ELDK " =
from ftp, it cannot be executed,why?
       "./gcc=20
        gcc: cannot execute "
   =20
     thanks a lot!
