Return-Path: <happyphot@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.204])
	by ozlabs.org (Postfix) with ESMTP id 9C7B86886E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Dec 2005 15:02:50 +1100 (EST)
Received: by zproxy.gmail.com with SMTP id q3so18393nzb
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Dec 2005 20:02:49 -0800 (PST)
Message-ID: <000401c60063$3dc46040$0760120a@photon>
From: "HappyPhot" <happyphot@gmail.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Wed, 14 Dec 2005 11:41:45 +0800
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="big5"; reply-type=original
Subject: "make xconfig" error (2.4.25 devel)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,
  I am trying "linuxppc_2_4_devel-2005-10-25-1440".
The "make xconfig" seems not work. ("make menuconfig" is ok)
It shows :
======================================
....
./tkparse < ../arch/ppc/config.in >> kconfig.tk
arch/ppc/8xx_io/Config.in: 312: unknown define_bool value
make[1]: *** [kconfig.tk] Error 1
....
======================================
  Does this version support "make xconfig" ?

thank you,
/HappyPhot
