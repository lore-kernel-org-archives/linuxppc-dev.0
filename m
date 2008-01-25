Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BD48FDE00C
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 10:57:09 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	m0PMdSkt016965
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 15:39:28 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m0PMdRpM007328
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 16:39:28 -0600 (CST)
Message-ID: <479A651F.2070109@freescale.com>
Date: Fri, 25 Jan 2008 16:39:27 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: drivers/char/hvc_* and /Documentation/powerpc/hvcs.txt
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I'm working on a console driver for the Freescale hypervisor.  I notice a bunch 
of hvc_* files in the drivers/char directory.  I also noticed 
/Documentation/powerpc/hvcs.txt.

My guess is that hvcs.txt talks about drivers/char/hvcs.c, which is a console 
driver specific to some IBM hypervisor.  The hvc_*.c files are based on that 
code but they're more generic and allow people to write console drivers for 
other hypervisors easliy.  Am I right?

If so, does this mean that I can take hvc_beat.c, modify it to make Freescale 
hypervisor calls instead, and presto, I'm done?

-- 
Timur Tabi
Linux kernel developer at Freescale
