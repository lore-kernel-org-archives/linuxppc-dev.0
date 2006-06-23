Return-Path: <matt@genesi-usa.com>
Received: from mail.genesippc.com (mithrandir.softwarenexus.net [66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 850A767A60
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jun 2006 20:43:51 +1000 (EST)
Received: from p54b0d8f3.dip.t-dialin.net ([84.176.216.243] helo=yukito)
	by mail.genesippc.com with esmtpa (Exim 4.62 (FreeBSD))
	(envelope-from <matt@genesi-usa.com>) id 1Ftj4v-000KDw-Dp
	for linuxppc-dev@ozlabs.org; Fri, 23 Jun 2006 10:39:58 +0000
From: "Matt Sealey" <matt@genesi-usa.com>
To: <linuxppc-dev@ozlabs.org>
Subject: cpu power "management" for non-dfs chips with no pmu (for instance,
	750cxe and mpc7447 in pegasos)
Date: Fri, 23 Jun 2006 05:43:43 -0500
Message-ID: <018201c696b1$e942ba40$99dfdfdf@bakuhatsu.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Reply-To: matt@genesi-usa.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Is there any support for using the ICTC to reduce CPU power and so on
for PowerPC currently, in absense of a real PMU like on Macs, or the
dual-PLL/DFS/DFS4 stuff in newer G3 and G4 chips?

I was wondering if there were any definitive performance benchmarks
to see if the setting had any appreciable effect in the first place.
If it doesn't do much more than kill a couple of milliwatts and the
switch between ICTC settings has too high a latency, it would make
no sense in a desktop system.

I am basically trying to evaluate if we can do ANYTHING to reduce
power consumption of systems which are idle, as I have noticed that
for running firmware (sitting at a Forth prompt) and booting a
Linux kernel and doing some work (for instance a simple benchmark),
power consumption barely changes at all. The difference between an
idle G4 and a running G4 is negligible. RC5 makes a big difference
but it is heavily tuned. Most people won't run RC5 all the time to
stress the CPU to the level that it wants to draw a couple extra
watts, I think.

Comments? :)

-- 
Matt Sealey <matt@genesi-usa.com>
Manager, Genesi, Developer Relations
