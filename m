Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E2A91B6F81
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Sep 2011 13:22:01 +1000 (EST)
Subject: Re: [PATCH 1/4] powerpc/85xx: Rename PowerPC core nodes to match
	other	e500mc based .dts
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4E5FEE40.7080901@freescale.com>
Date: Thu, 1 Sep 2011 22:21:55 -0500
Message-Id: <0995BAB2-7865-4E95-A842-EFE486FFDAC4@kernel.crashing.org>
References: <1314905175-4371-1-git-send-email-galak@kernel.crashing.org>
	<4E5FEE40.7080901@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 1, 2011, at 3:42 PM, Scott Wood wrote:

> On 09/01/2011 02:26 PM, Kumar Gala wrote:
>> The P4080 silicon device tree was using PowerPC,4080 while the other
>> e500mc based SoCs used PowerPC,e500mc.  Use the core name to be
>> consistent going forward.
>=20
> Why are we not using the generic names recommendation?
>=20
> Is the "PowerPC" vendor string still appropriate here, or should we =
use
> "fsl"?
>=20
> -Scott

I have mixed feelings on this.  The PowerPC,NAME has a long history & =
precedence.  Is there any use or value to change this?

- k=
