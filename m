Return-Path: <happyphot@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.196])
	by ozlabs.org (Postfix) with ESMTP id D82CA6886E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Dec 2005 18:51:17 +1100 (EST)
Received: by zproxy.gmail.com with SMTP id s18so1754754nze
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Dec 2005 23:51:16 -0800 (PST)
Message-ID: <003201c5ffb9$fe0d6310$0760120a@photon>
From: "HappyPhot" <happyphot@gmail.com>
To: <hs@denx.de>,
	<linuxppc-embedded@ozlabs.org>
References: <AHEILKONAKAEJPHNMOPNIEDBCEAA.hs@denx.de>
Date: Tue, 13 Dec 2005 15:50:38 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: MPC8245 with its internal UART
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
  I get this one "linuxppc_2_4_devel-2005-10-25-1440.tar.bz2"
and try "make CPC45_defconfig". But it shows "No rule to make 
target ...."
  Did I do something wrong ?

thank you,
/HappyPhot


----- Original Message ----- 
From: "Heiko Schocher" <hs@denx.de>
To: <linuxppc-embedded@ozlabs.org>
Cc: <happyphot@gmail.com>
Sent: Wednesday, December 07, 2005 3:36 PM
Subject: MPC8245 with its internal UART


Hello,

> Who can tell me which flatform is similar to mine ? I've tried
> "make sandpoint_defconfig", but seems not the right one.

If you want to use Linux 2.4.25, you can try CPC45_defconfig
from the Denx Kernel ...

Best regards,
Heiko
