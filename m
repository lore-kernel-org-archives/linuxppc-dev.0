Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id C1CB6DDE2A
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 00:02:36 +1000 (EST)
Date: Tue, 10 Jun 2008 18:02:33 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull from 'powerpc-next' branch
Message-ID: <20080610140233.GA4061@polina.dev.rtsoft.ru>
References: <Pine.LNX.4.64.0806042232040.23796@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <Pine.LNX.4.64.0806042232040.23796@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 04, 2008 at 10:32:38PM -0500, Kumar Gala wrote:
> Please pull from 'powerpc-next' branch of
> 
> 	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git powerpc-next

Kumar, could you provide some status for these patches?

* rdk/83xx/qe queue

[PATCH 1/7] [POWERPC] sysdev: implement FSL GTM support
http://patchwork.ozlabs.org/linuxppc/patch?id=18669

[PATCH 2/7] [POWERPC] QE: add support for QE USB clocks routing
http://patchwork.ozlabs.org/linuxppc/patch?id=18670

[PATCH 3/7] [POWERPC] QE: prepare QE PIO code for GPIO LIB support
http://patchwork.ozlabs.org/linuxppc/patch?id=18671

[PATCH 4/7] [POWERPC] QE: implement support for the GPIO LIB API
http://patchwork.ozlabs.org/linuxppc/patch?id=18672

[PATCH 5/7] [POWERPC] 83xx: new board support: MPC8360E-RDK
http://patchwork.ozlabs.org/linuxppc/patch?id=18673

[PATCH 7/7] [POWERPC] qe_lib: switch to the cpm_muram implementation
http://patchwork.ozlabs.org/linuxppc/patch?id=18675

* MPC837xRDB ethernet fix

[POWERPC] 83xx: MPC837xRDB's VSC7385 ethernet switch isn't on the MDIO bus
http://patchwork.ozlabs.org/linuxppc/patch?id=17389

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
