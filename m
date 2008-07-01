Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 6113FDDFBC
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jul 2008 01:40:59 +1000 (EST)
Message-ID: <486A4FFE.6020407@scram.de>
Date: Tue, 01 Jul 2008 17:40:46 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH2/2] [POWERPC] CPM1: implement GPIO LIB API on CPM1
	Freescale SoC.
References: <4808D606.5070309@scram.de>
	<fa686aa40804210730s2f356d92ib4247423d55911cd@mail.gmail.com>
In-Reply-To: <fa686aa40804210730s2f356d92ib4247423d55911cd@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Grant,

sorry for the late response on this one.

> 2. You need to specifiy exact chip names in your compatible string.
> "fsl,cpm1-pario-<bank>" is a made up thing.

>>  +       for_each_compatible_node(np, NULL, "fsl,cpm1-pario-bank16")
>>  +               cpm1_gpiochip_add16(np);
>>  +
>>  +       for_each_compatible_node(np, NULL, "fsl,cpm1-pario-bank32b")
>>  +               cpm1_gpiochip_add32(np);
>>  +
>>  +       /* Port E uses CPM2 layout */
>>  +       for_each_compatible_node(np, NULL, "fsl,cpm1-pario-bank32e")
>>  +               cpm2_gpiochip_add32(np);

What do you suggest here?

All GPIO ports of CPM1/CPM2 are on the SoC, so the chip name is in fact the CPU itself
(like fsl,mpc866-pario-bank16).


Thanks,
Jochen
