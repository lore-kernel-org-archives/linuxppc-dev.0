Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C0F8ADDDF2
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 19:43:03 +1100 (EST)
Subject: RE: [PATCH v7 3/9] add Freescale SerDes PHY support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Li Yang <LeoLi@freescale.com>
In-Reply-To: <989B956029373F45A0B8AF029708189001A1C7DF@zch01exm26.fsl.freescale.net>
References: <1192793930-26039-1-git-send-email-leoli@freescale.com>
	<1192793930-26039-2-git-send-email-leoli@freescale.com>
	<1192793930-26039-3-git-send-email-leoli@freescale.com>
	<1192793930-26039-4-git-send-email-leoli@freescale.com>
	<fa686aa40710190835t4329d52bt74fb3b8f30b25847@mail.gmail.com>
	<68738B73-92D6-459F-88A7-BBE66967A3A0@kernel.crashing.org>
	<989B956029373F45A0B8AF029708189001A1C7DF@zch01exm26.fsl.freescale.net>
Content-Type: text/plain
Date: Wed, 21 Nov 2007 19:42:47 +1100
Message-Id: <1195634567.6970.77.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I'm ok for it to be taken care of in u-boot for now.  However, if we
> later plan to add power management support to this block.  We probably
> have to do it in kernel.

In that case, can't it be just saving/restoring ? That's easier than
supporting full configuration of random user setups

Ben.
