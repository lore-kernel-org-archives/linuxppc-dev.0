Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 8B732DE191
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 02:48:19 +1000 (EST)
Message-ID: <486519DD.1040907@scram.de>
Date: Fri, 27 Jun 2008 18:48:29 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
References: <200806041706.21557.sr@denx.de> <4846B39F.3010601@freescale.com>	
	<20080604154351.GB10393@ld0162-tx32.am.freescale.net>	
	<20080604211942.2bddc860@zod.rchland.ibm.com>	
	<4848028B.5060105@freescale.com>	
	<fa686aa40806050839h55d8e358m93248414507f10e2@mail.gmail.com>	
	<48480987.1070701@freescale.com>
	<1212726040.12464.21.camel@pasglop>
	<4862BCCF.6040403@freescale.com>
In-Reply-To: <4862BCCF.6040403@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stefan Roese <sr@denx.de>, linuxppc-dev@ozlabs.org,
	Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Timur,

> Anyone know when of_i2c.c is going to come "online" replace what's in fsl_soc.c?

There is a patch being prepared to convert i2c-mpc from a platform driver to an of_platform driver
making the fsl_soc.c code obsolete. See: http://patchwork.ozlabs.org/linuxppc/patch?id=18898

Thanks,
Jochen
