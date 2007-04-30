Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8B935DDF09
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 May 2007 01:42:26 +1000 (EST)
Received: from [10.0.0.107] (cbluk-gw0.cambridgebroadband.com [217.204.121.82])
	by cambridgebroadband.com (8.12.11.20060308/8.12.8) with ESMTP id
	l3UFFfGY021811
	for <linuxppc-embedded@ozlabs.org>; Mon, 30 Apr 2007 16:15:42 +0100
Message-ID: <4636081D.2000507@cambridgebroadband.com>
Date: Mon, 30 Apr 2007 16:15:41 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Anyone using mpc832x_mds & freescale's GIT repo?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi list,

I've got an MPC8323E-MDS-PB development board, which is
running a year-old BSP from freescale.  I wanted to track
the most current developments so I cloned

	http://opensource.freescale.com/pub/scm/linux-2.6-83xx.git

and rebuilt with ARCH=powerpc and using the mpc832x_mds_defconfig.

I now don't get any serial console output after u-boot has
started the kernel.

My questions are:

1.	Is anyone else using this GIT repo with this board?

2.	Is there an example u-boot environment for starting the latest kernels
	on this board?

3.	Am I using the right ARCH.  (I chose ARCH=powerpc because there's
	no defconfig file for this board under arch/ppc!)

TIA,

Alex
	
