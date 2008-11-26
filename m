Return-Path: <nvbolhuis@aimvalley.nl>
Received: from smtp-vbr10.xs4all.nl (smtp-vbr10.xs4all.nl [194.109.24.30])
	by ozlabs.org (Postfix) with ESMTP id D00B3DDEDF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Nov 2008 21:03:30 +1100 (EST)
Received: from mail3.aimsys.nl (a80-127-156-242.adsl.xs4all.nl
	[80.127.156.242])
	by smtp-vbr10.xs4all.nl (8.13.8/8.13.8) with ESMTP id mAQ9riVE060389
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Nov 2008 10:53:49 +0100 (CET)
	(envelope-from nvbolhuis@aimvalley.nl)
Message-ID: <492D1CA5.2090007@aimvalley.nl>
Date: Wed, 26 Nov 2008 10:53:41 +0100
From: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
MIME-Version: 1.0
To: LinuxPPC-Embedded <linuxppc-embedded@ozlabs.org>
Subject: too few bogoMips on MPC8313E-RDB ?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


This is what a linux-2.6.x reports (for the MPC8313E running at 333 MHz):
Calibrating delay loop... 83.20 BogoMIPS (lpj=166400)

Which can't be correct.

A MPC870 (running at 133 mhz) has ~ 131.07 BogoMIPS

Anyone know why it's only 83.20 ?

Of course it's only a benchmark figure. I don't know if
CPU performance is *really* lacking, I sure hope not.
