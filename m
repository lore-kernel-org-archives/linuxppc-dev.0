Return-Path: <pterry@micromemory.com>
Received: from mail.micromemory.com (mx30.micromemory.com [67.95.226.74])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 32ECDDE055
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 06:23:42 +1100 (EST)
Received: from [192.168.0.90] by micromemory.com (MDaemon PRO v9.6.5)
	with ESMTP id md50000566380.msg
	for <linuxppc-dev@ozlabs.org>; Wed, 02 Apr 2008 12:14:26 -0700
Subject: Two MPC8641D's on a single JTAG chain with BDI2000/3000. Anyone
	got it to work?
From: Phil Terry <pterry@micromemory.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Wed, 02 Apr 2008 12:14:23 -0700
Message-Id: <1207163663.2030.20.camel@pterry-fc6.micromemory.com>
Mime-Version: 1.0
Reply-To: pterry@vmetro.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Guys'n'Gals,

We have a board with two Freescale MPC8641D chips (ie four cores, two in
each chip) on a single jtag chain, nothing else on the chain. We are
unable to get BDI and WindRiver jtag debuggers to work with both chips,
only the second (last) chip works. With the BDI we can configure to work
with both cores in the second chip, with windriver only one core in
second chip configuration works.

If we split the jtag chain in the lab we can work with each processor
independently with no problems. We want both to work however.

On the BDI if we configure predecessor 1,8, successor 0,0 we can talk to
the second chip as expected, but if we try predecessor 0,0 successor 1,8
to talk to the first chip we get nothing.

Is there something else we need to configure in either the BDM or the
Freescale chip to get this to work? 

Any suggestions or pointers to helpful resources welcome, either
privately or to the list if this isn't too far off topic.

Cheers
Phil
