Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B1276B70D2
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Oct 2010 00:19:21 +1100 (EST)
Subject: Re: [PATCH 1/2] P4080/eLBC: Make Freescale elbc interrupt common to
	elbc devices
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1287386552-10647-1-git-send-email-tie-fei.zang@freescale.com>
Date: Tue, 19 Oct 2010 08:18:30 -0500
Message-Id: <2D2A6B88-DA17-467D-BB43-919C1CAAB894@kernel.crashing.org>
References: <1287386552-10647-1-git-send-email-tie-fei.zang@freescale.com>
To: Roy Zang <tie-fei.zang@freescale.com>
Cc: B07421@freescale.com, dedekind1@gmail.com, B25806@freescale.com,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	akpm@linux-foundation.org, dwmw2@infradead.org, B11780@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 18, 2010, at 2:22 AM, Roy Zang wrote:

> Move Freescale elbc interrupt from nand dirver to elbc driver.
> Then all elbc devices can use the interrupt instead of ONLY nand.
>=20
> For former nand driver, it had the two functions:
>=20
> 1. detecting nand flash partitions;
> 2. registering elbc interrupt.
>=20
> Now, second function is removed to fsl_lbc.c.
>=20
> Signed-off-by: Lan Chunhe-B25806 <b25806@freescale.com>
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> Reviewed-by: Anton Vorontsov <cbouatmailru@gmail.com>
> Cc: Wood Scott-B07421 <B07421@freescale.com>
> ---

Roy, this is a nit, but are these really p4080 specific?  just wondering =
why the subject is P4080/eLBC:...

- k=
