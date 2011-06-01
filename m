Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 31EE2B6F7C
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Jun 2011 07:56:53 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [git pull] Please pull powerpc.git merge branch
Date: Wed, 1 Jun 2011 21:56:35 +0000
Message-ID: <BANLkTi==R2ZQOePpDHjhjLbH18EhfnWFaw@mail.gmail.com>
References: <alpine.LFD.2.00.1105200934580.11641@right.am.freescale.net>
In-Reply-To: <alpine.LFD.2.00.1105200934580.11641@right.am.freescale.net>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 20, 2011 at 9:35 AM, Kumar Gala <galak@kernel.crashing.org> wro=
te:

> Shaohui Xie (2):
> =A0 =A0 =A0powerpc/fsl_rio: move machine_check handler

This patch causes a build failure if CONFIG_FSL_RIO is not defined:

arch/powerpc/kernel/built-in.o: In function `machine_check_e500mc':
/home/b04825/git/linux.hv/arch/powerpc/kernel/traps.c:429: undefined
reference to `fsl_rio_mcheck_exception'
arch/powerpc/kernel/built-in.o: In function `machine_check_e500':
/home/b04825/git/linux.hv/arch/powerpc/kernel/traps.c:519: undefined
reference to `fsl_rio_mcheck_exception'

--=20
Timur Tabi
Linux kernel developer at Freescale=
