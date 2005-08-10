Return-Path: <Baohua.WANG@alcatel-sbell.com.cn>
Received: from mail.alcatel-sbell.com.cn (nat1.alcatel-sbell.com.cn
	[202.96.203.177]) by ozlabs.org (Postfix) with ESMTP id A723567E8E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 11:39:26 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Date: Wed, 10 Aug 2005 09:39:12 +0800
Message-ID: <A9DE2BAF233E444FA9C5E77A5825A01E86505B@ydmail.sbell.com.cn>
From: "FCG WANG Baohua" <Baohua.WANG@alcatel-sbell.com.cn>
To: <wd@denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Some version different
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Denk:
 I want to ask some questions about the different version:
  1. The linuxppc_2_4_devel   and   the linux-2.4.25.tar.bz2 in ELDK =
3.1.1 package
  2.  The ppcboot 0.9.2 compiled with mvstia devrock   and    the  =
U-Boot 1.1.2 compiled  with ELDK
 =20
  Does the kernel freeze at "transferring control to linux" could be =
these different versions?=20

  Another question:
  1 why I configed the kernel with CONFIG_HD860 in "make menuconfig" but =
the code in CONFIG_HD860=20
     isn't compiled at all ! What's the perhaps reasons? I checked the =
Makefile and the .config, there is all with=20
     CONFIG_HD860 =3D y , But I add any string to CONFIG_HD860 code, =
there is nothing error when compiled !
   2  How to get board info "struct bd_info" in init/main.c ? I want to =
use printf of bd_t->bi_mon_fnc->printf() to=20
       print some string on console. Does it possible? But the code is =
only in head_8xx.S, How to get the bd* data in=20
       main.c ? Some board use get_board_info(). But how can I use it?=20
      thanks!
=20
