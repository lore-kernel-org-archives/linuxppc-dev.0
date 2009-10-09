Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1FD94B7B72
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 10 Oct 2009 05:15:55 +1100 (EST)
Date: Fri, 9 Oct 2009 13:16:17 -0500
From: Scott Wood <scottwood@freescale.com>
To: Roberto Guerra <roberto.j.guerra@gmail.com>
Subject: Re: Support for S29JL064 in MPC8272ADS?
Message-ID: <20091009181617.GA14304@loki.buserror.net>
References: <7c4144600910090714g524bad07ubf6cad3aaf8085ff@mail.gmail.com>
	<20091009170433.GA17372@b07421-ec1.am.freescale.net>
	<7c4144600910091059o492c870cn3ea1c1a96d2f0823@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7c4144600910091059o492c870cn3ea1c1a96d2f0823@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 09, 2009 at 01:59:58PM -0400, Roberto Guerra wrote:
> No. I did not. My FDT was simplified from the stock MPC8272ADS:
> => fdt list
> / {
>         model = "pq2fads";
>         compatible = "fsl,pq2fads";
>         #address-cells = <0x00000001>;
>         #size-cells = <0x00000001>;
>         cpus {
>         };
>         memory {
>         };
>         soc@f0000000 {
>         };
>         chosen {
>         };
> };

You need more than that.  What happened to all the content of those nodes?

> I am searching how I could add the mtd branch between the "soc" and
> the "chosen".

Look at the localbus node on the mpc8272ads dts.

Look at (and use) a recent upstream kernel, if you're not already.

-Scott
