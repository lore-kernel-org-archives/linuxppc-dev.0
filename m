Return-Path: <lists@nerdbynature.de>
Received: from mail.g-house.de (ns2.g-housing.de [81.169.133.75])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B2641DDF30
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Mar 2007 03:07:04 +1000 (EST)
Received: from [77.99.119.75]
	(helo=77-99-119-75.cable.ubr04.linl.blueyonder.co.uk)
	by mail.g-house.de with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50) id 1HV9QX-0001Kv-Tv
	for linuxppc-dev@ozlabs.org; Sat, 24 Mar 2007 17:49:17 +0100
Date: Sat, 24 Mar 2007 16:48:37 +0000 (GMT)
From: Christian Kujau <lists@nerdbynature.de>
To: linuxppc-dev@ozlabs.org
Subject: more bogomips :)
Message-ID: <Pine.LNX.4.64.0703241645360.10654@sheep.housecafe.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: "evil@g-house.de"@mail.g-house.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I know bogomips are kinda "bogus by definition", but I'll ask anyway, 
out of curiosity:

--- ppc-cpuinfo.2.6.20-rc6      2007-01-27 12:33:00.000000000 +0000
+++ ppc-cpuinfo.2.6.21-rc4-git6 2007-03-24 16:25:26.000000000 +0000
@@ -1,8 +1,8 @@
  processor      : 0
  cpu            : 7447A, altivec supported
-clock          : 1199.999997MHz
+clock          : 1199.999000MHz
  revision       : 0.1 (pvr 8003 0101)
-bogomips       : 36.73
+bogomips       : 73.47
  timebase       : 18432000
  platform       : PowerMac
  machine                : PowerBook6,5

It seems that with a more recent kernel, bogomips have doubled (both 
with CONFIG_HZ=1000, if this matters). How comes?

Thanks,
Christian
-- 
BOFH excuse #108:

The air conditioning water supply pipe ruptured over the machine room
