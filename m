Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E42921007D4
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jan 2010 09:05:04 +1100 (EST)
Subject: Re: openpic specification
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4B518E4B.4010202@alcatel-lucent.com>
Date: Fri, 15 Jan 2010 16:04:56 -0600
Message-Id: <451D99C3-3C43-450E-A1F5-C828A5EA4BFA@kernel.crashing.org>
References: <4B518E4B.4010202@alcatel-lucent.com>
To: gshan <gshan@alcatel-lucent.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 16, 2010, at 4:00 AM, gshan wrote:

> I ever searched openpic specification on google for several times, but =
unfortunately nothing found.
> Could anybody point me where I can get the openpic specification?
>=20
> The source code seems being from IBM: arch/powerpc/sysdev/mpic.c

While not the openpic spec if you grab any of the Freescale RM for =
MPC85xx chips there will be a chapter on the PIC that is an "openPIC" =
based interrupt controller.

- k=
