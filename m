Return-Path: <marc.leeman@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.193])
	by ozlabs.org (Postfix) with ESMTP id 5AFC12BDF2
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Nov 2004 17:23:42 +1100 (EST)
Received: by rproxy.gmail.com with SMTP id y7so285515rne
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Nov 2004 22:23:41 -0800 (PST)
Message-ID: <1f729c48041124222310501eae@mail.gmail.com>
Date: Thu, 25 Nov 2004 07:23:41 +0100
From: Marc Leeman <marc.leeman@gmail.com>
To: zhonglei@rcs-9000.com
In-Reply-To: <1f729c4804112422211cd6ba60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200411251042.AA26804430@RCS-9000.COM>
	<1f729c4804112422211cd6ba60@mail.gmail.com>
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

> 2. As Wolfgang told you in the U-boot mailing list, check if the DHCP
> packets actually arrive on the server

2b. and verify if your DHCP server handles them: sends out an IP and
has that IP linked to a particular NFS share.

You should have something like:
Nov 24 08:35:17 gemini dhcpd: BOOTREQUEST from 00:04:a5:04:05:53 via eth0
Nov 24 08:35:17 gemini dhcpd: BOOTREPLY for 150.158.231.130 to
hydra_stream_malm.01 (00:04:a5:04:05:53) via eth0
Nov 24 08:35:21 gemini rpc.mountd: authenticated mount request from
150.158.231.130:800 for /home/firmware/mleeman/targets/target.3.0.0.0
(/home/firmware/mleeman/targets/target.3.0.0.0)


--=20
ash nazg durbatul=FBk, ash nazg gimbatul,
ash nazg thrakatul=FBk agh burzum-ishi krimpatul
