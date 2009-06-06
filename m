Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9C974B7098
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  7 Jun 2009 02:06:29 +1000 (EST)
MIME-Version: 1.0
In-Reply-To: <1244203514-12516-3-git-send-email-w.sang@pengutronix.de>
References: <1244203514-12516-1-git-send-email-w.sang@pengutronix.de>
	<1244203514-12516-3-git-send-email-w.sang@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 6 Jun 2009 10:05:41 -0600
Message-ID: <fa686aa40906060905y1d39dce1j87d993ceb94273be@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] mtd/maps/mtd-ram: add an of-platform driver
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree-discuss@ozlabs.org, albrecht.dress@arcor.de,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Ben Dooks <ben-linux@fluff.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 5, 2009 at 6:05 AM, Wolfram Sang<w.sang@pengutronix.de> wrote:
> diff --git a/Documentation/powerpc/dts-bindings/mtd-ram.txt b/Documentati=
on/powerpc/dts-bindings/mtd-ram.txt
> new file mode 100644
> index 0000000..a2e9932
> --- /dev/null
> +++ b/Documentation/powerpc/dts-bindings/mtd-ram.txt
> @@ -0,0 +1,18 @@
> +RAM emulating an MTD
> +
> +An external RAM like SRAM or FRAM can also be treated as an MTD.
> +
> + - compatible : should contain the specific model of the RAM chip
> + =A0 used, if known, followed by "mtd-ram".
> + - reg : Address range of the RAM chip
> + - bank-width : Width (in bytes) of the RAM bank.

Question: why is bank-width even relevant for a RAM device?

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
