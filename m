Return-Path: <root@danielinux.net>
Received: from ms005msg.fastwebnet.it (ms005msg.fastwebnet.it [213.140.2.50])
	by ozlabs.org (Postfix) with ESMTP id 73DA867A7E
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Mar 2005 02:30:57 +1100 (EST)
From: Daniele Lacamera <root@danielinux.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 24 Mar 2005 16:25:41 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200503241625.42143.root@danielinux.net>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: Newer laptops & CPU speed
Reply-To: root@danielinux.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Hi !
> 
> It seems the new laptops are booting with CPU set to low
> speed. /proc/cpuinfo outputs the wrong fequency (thinks it's high 
speed)
> but bogomips shows that it's running at about half speed. This patch
> against 2.6.11 (will not apply on 2.6.10) adds proper cpufreq support 
so
> that the boot speed is recognized (fixing /proc/cpuinfo output) and so
> you can acutally use cpufreq interface & utilities to switch to full
> speed (I recommend powernowd).

> This is completely untested as I don't have access to any of those new
> models yet, so I'm waiting for some feedback before submitting 
upstream.

> Ben.
[patch follows]

Ben,
your patch seems to be working very well on my new 1.5GHz 12" pbook.
Bogomips more than doubled in /proc/cpuinfo, from about 700 to 1495.04.

Thanks.

-- 
Daniele Lacamera
root{at}danielinux.net
