Return-Path: <dgibson@ozlabs.org>
Date: Sat, 5 Jul 2008 11:28:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [alsa-devel] [PATCH 2/3] ALSA SoC: Add mpc5200-psc I2S driver
Message-ID: <20080705012844.GB3032@yookeroo.seuss>
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<20080701235335.16923.43253.stgit@trillian.secretlab.ca>
	<9e4733910807020651u368763en9362653ed613b2d1@mail.gmail.com>
	<20080703162809.GH2284@secretlab.ca>
	<B7AF0D32-4A05-4DE1-88F5-06B28C9723EF@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <B7AF0D32-4A05-4DE1-88F5-06B28C9723EF@freescale.com>
Cc: liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org,
	broonie@opensource.wolfsonmicro.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 04, 2008 at 07:03:25AM -0400, Timur Tabi wrote:
>> 	i2s@2200 {		// PSC2
>> 		compatible = "fsl,mpc5200b-psc-i2s","fsl,mpc5200-psc-i2s";
>> 		cell-index = <1>;
>
> cell-index should be zero-based, not one-based.

Well...since cell-index is for indexing shared resources, the
cell-index values should be whatever the convention is for that shared
resource, which can be defined as whatever is convenient for that
resource.  I think that's been zero-based in every user of cell-index
so far, but there's no reason it *has* to be if a different
enumeration is convenient for the shared resource in question.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
