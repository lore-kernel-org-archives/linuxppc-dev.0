Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id B8C1ADE083
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 21:45:42 +1000 (EST)
Date: Fri, 11 Apr 2008 15:45:38 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: patches for 2.6.26
Message-ID: <20080411114538.GA17447@polina.dev.rtsoft.ru>
References: <D9A4BB4A-970C-4E9E-9174-BA8C0191CCA2@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <D9A4BB4A-970C-4E9E-9174-BA8C0191CCA2@kernel.crashing.org>
Cc: ppc-dev list <linuxppc-dev@ozlabs.org>
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

On Thu, Apr 10, 2008 at 09:21:34AM -0500, Kumar Gala wrote:
> Guy's
>
> if you have work you want in 2.6.26 related to Freescale PPC's let me  
> know.  Ideally you can provide links to the patches in 
> http://patchwork.ozlabs.org/linuxppc/

Please take a look at these:

[POWERPC] mpc8315: fix USB UTMI Host setup
http://patchwork.ozlabs.org/linuxppc/patch?id=17782

[POWERPC] qe_lib and ucc_geth: switch to the cpm_muram implementation
http://patchwork.ozlabs.org/linuxppc/patch?id=17441
^ Scott and Timur say that patch looks fine.

[POWERPC] 83xx: mpc837x_rdb: add simple-bus compatible matching
http://patchwork.ozlabs.org/linuxppc/patch?id=17405

[POWERPC] 83xx: MPC837xRDB's VSC7385 ethernet switch isn't on the MDIO bus
http://patchwork.ozlabs.org/linuxppc/patch?id=17389

[POWERPC] fsl_soc: add support for "fsl, soc" compatible matching
http://patchwork.ozlabs.org/linuxppc/patch?id=17289

[POWERPC] UCC nodes cleanup
http://patchwork.ozlabs.org/linuxppc/patch?id=17290

UPM Patches
http://patchwork.ozlabs.org/linuxppc/patch?id=17291
http://patchwork.ozlabs.org/linuxppc/patch?id=17292
^ Needed to be in-tree so I can ask to merge FSL UPM NAND driver just after
OF GPIO API merge.


Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
