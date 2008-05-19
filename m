Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id B3F87DE278
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 03:45:59 +1000 (EST)
Date: Mon, 19 May 2008 21:45:58 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 0/7] Patches for Kumar's powerpc-next tree
Message-ID: <20080519174558.GA26229@polina.dev.rtsoft.ru>
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

Hello Kumar,

Please consider applying these patches.


[PATCH 1/7] [POWERPC] sysdev: implement FSL GTM support
^ no changes

[PATCH 2/7] [POWERPC] QE: add support for QE USB clocks routing
[PATCH 3/7] [POWERPC] QE: prepare QE PIO code for GPIO LIB support
[PATCH 4/7] [POWERPC] QE: implement support for the GPIO LIB API
^ added Acked-By: Timur Tabi <timur@freescale.com>

[PATCH 5/7] [POWERPC] 83xx: new board support: MPC8360E-RDK
[PATCH 6/7] [POWERPC] booting-without-of: add FHCI USB, FSL MCU, FSL UPM and GPIO LEDs bindings
^ no changes

[PATCH 7/7] [POWERPC] qe_lib: switch to the cpm_muram implementation
^ Added qe_* -> cpm_* defines.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
