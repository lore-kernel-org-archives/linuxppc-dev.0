Return-Path: <ostampflee@terrasoftsolutions.com>
Received: from newhope.terraplex.com (newhope1.terraplex.com [66.7.161.2])
	by ozlabs.org (Postfix) with ESMTP id BBD786804E
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Aug 2005 02:19:59 +1000 (EST)
Received: from [192.168.0.105] (S010600095bdadbc7.gv.shawcable.net
	[24.68.241.79])
	by newhope.terraplex.com (Postfix) with ESMTP id 285A43580D0
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2005 10:02:10 -0600 (MDT)
From: Owen Stampflee <ostampflee@terrasoftsolutions.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Message-Id: <1123689464.3664.10.camel@beast.terraplex.com>
Mime-Version: 1.0
Date: Wed, 10 Aug 2005 08:57:44 -0700
Subject: PowerBook5,4 sleep w/2.6.12
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anyone else having troubles with it? I've tried 2.6.12-rc2 and
2.6.12.(3|4). Found several success reports on Google about 2.6.12
sleeping this laptop correctly.

My PowerBook refuses to wake up, the screen stays blank, PCMCIA card
lights don't turn on, but I do hear the CDROM drive motor kick.

Sleep works perfectly using 2.6.10, and 2.6.12 works fine on a
co-worker's PowerBook5,2.

Any input would be greatly appreciated, I seem to remember a tidbit
about an early wakeup console, but I'm guessing that doesnt even work.

Thanks,
Owen
