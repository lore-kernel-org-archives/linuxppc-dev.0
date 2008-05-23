Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 7D117DE9C3
	for <linuxppc-dev@ozlabs.org>; Sat, 24 May 2008 02:38:12 +1000 (EST)
Date: Fri, 23 May 2008 20:38:11 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 0/7] Patches for Kumar's powerpc-next tree
Message-ID: <20080523163811.GA12181@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Kumar,

Here is updated series, with your comments addressed. Patches are
rebased on top of your current powerpc-next branch.

[PATCH 1/7] [POWERPC] sysdev: implement FSL GTM support
- added "depends on" to the Kconfig
- reverted to arch_initcall
- added Context: tip to the documentation
- reset_timer -> set_timer
  reset_utimer -> set_exact_timer + improved kerneldoc
- put_timer now stops the timer

[PATCH 2/7] [POWERPC] QE: add support for QE USB clocks routing
[PATCH 3/7] [POWERPC] QE: prepare QE PIO code for GPIO LIB support
[PATCH 4/7] [POWERPC] QE: implement support for the GPIO LIB API
^ reverted to arch_initcall

[PATCH 5/7] [POWERPC] 83xx: new board support: MPC8360E-RDK
[PATCH 6/7] [POWERPC] booting-without-of: add FHCI USB, FSL MCU, FSL UPM and GPIO LEDs bindings
[PATCH 7/7] [POWERPC] qe_lib: switch to the cpm_muram implementation
^ now it doesn't touch ucc_{slow,fast}.c

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
