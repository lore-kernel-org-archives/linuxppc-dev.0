Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id C359267B5E
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Aug 2006 06:49:27 +1000 (EST)
Subject: Re: Compilation error in fsl_soc.c
From: Jon Loeliger <jdl@freescale.com>
To: Vitaly Bordug <vbordug@ru.mvista.com>
In-Reply-To: <20060731173959.03f57dd4@vitb.ru.mvista.com>
References: <67194FEE6056B947B4EF756C9E497A2EA198F8@zuk35exm60.ds.mot.com>
	<20060731173959.03f57dd4@vitb.ru.mvista.com>
Content-Type: text/plain
Message-Id: <1154378714.5107.44.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Mon, 31 Jul 2006 15:45:15 -0500
Cc: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 2006-07-31 at 08:39, Vitaly Bordug wrote:
> On Mon, 31 Jul 2006 08:37:56 +0100
> "Demke Torsten-atd012" <torsten.demke@motorola.com> wrote:
> 
> > Hi all,
> > 
> > with a recent versions from Paulus merge-tree the compilation
> > of MPC85xx CDS failed with following output:
> > ...

> 
> No, since it is just going to be out.
> 
> I'll submit some patches addressing that this week...

Vitaly,

I have just posted some patches on linuxppc-dev
for the 86xx that cover the fsl_soc.c breakage here.

Thanks,
jdl
