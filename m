Return-Path: <marc.leeman@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.205])
	by ozlabs.org (Postfix) with ESMTP id 6FC622BDF2
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Nov 2004 17:21:42 +1100 (EST)
Received: by rproxy.gmail.com with SMTP id j1so229991rnf
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Nov 2004 22:21:40 -0800 (PST)
Message-ID: <1f729c4804112422211cd6ba60@mail.gmail.com>
Date: Thu, 25 Nov 2004 07:21:40 +0100
From: Marc Leeman <marc.leeman@gmail.com>
To: zhonglei@rcs-9000.com
In-Reply-To: <200411251042.AA26804430@RCS-9000.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200411251042.AA26804430@RCS-9000.COM>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: problem on netdevice
Reply-To: Marc Leeman <marc.leeman@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>    Sorry for bothering you! But would you please give me a hand.When I in=
sert a Intel Pro/100s server Adapter into the PCI slot on Lite5200(motorola=
 MPC5200 development kit) and start the embedded kernel,the kernel run into=
 a dead lock. (Before that I used 'make xconfig' to enable the e100 driver =
in kernel)

1. The kernel is not in a deadlock; it's just not able to mount a root
filesystem.

2. As Wolfgang told you in the U-boot mailing list, check if the DHCP
packets actually arrive on the server

# tail -f /var/log/syslog

If you do not check this first; doing anything else is useless.

--=20
ash nazg durbatul=FBk, ash nazg gimbatul,
ash nazg thrakatul=FBk agh burzum-ishi krimpatul
