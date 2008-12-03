Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 157DBDDDED
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Dec 2008 17:38:20 +1100 (EST)
Date: Wed, 3 Dec 2008 01:38:18 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Stefan Roese" <sr@denx.de>
Subject: Re: [U-Boot] NAND only (no NOR)
Message-ID: <20081203013818.016619b6@lappy.seanm.ca>
In-Reply-To: <200812030648.57618.sr@denx.de>
References: <4934F7FC.2030105@aimvalley.nl>
	<20081202215033.501f3403@lappy.seanm.ca>
	<200812030648.57618.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: u-boot@lists.denx.de, Norbert van Bolhuis <nvbolhuis@aimvalley.nl>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 3 Dec 2008 06:48:57 +0100
"Stefan Roese" <sr@denx.de> wrote:


> Currently you need to define the page-size of the NAND used for
> booting (512 bytes vs. 2k). The 2k 4xx NAND booting support is was
> done about 1/2 a year ago. So perhaps you tested this when this 2k
> support was not available yet.

We are running 1.3.0, so you are probably right. It may no longer be a
problem.

> Yes, I would recommend to do it this way if possible. A small NOR for
> U-Boot and environment and everything else in NAND. This makes things
> much easier. But I understand that this is sometimes a problem with
> space (2 FLASH chips) and costs.

Mainly cost. We didn't want to pay for a second chip.

Cheers,
   Sean
