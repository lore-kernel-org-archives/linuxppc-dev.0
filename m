Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 71E442BDF2
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Nov 2004 11:42:38 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
In-Reply-To: <1100852423.3855.2.camel@gaston>
References: <1100847411.25521.42.camel@gaston> <1100852423.3855.2.camel@gaston>
Content-Type: text/plain
Date: Mon, 22 Nov 2004 11:32:58 +1100
Message-Id: <1101083578.13597.5.camel@gaston>
Mime-Version: 1.0
Cc: gentoo-ppc-user@gentoo.org
Subject: TEST: Sleep patch #4
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ok, here's the 4th iteration of the patch. It includes John Steele Scott fixes for
cpufreq and the sound driver and fixes a problem where memory refresh wouldn't properly
be re-enabled on the video chip upon wakeup. I also cleaned a bit more the MDLL reset
code for r300, plus a couple of other things.

http://gate.crashing.org/~benh/albook-ibookg4-sleep-4.diff

Ben.
