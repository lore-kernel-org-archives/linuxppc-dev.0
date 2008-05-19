Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 70878DDED5
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 23:17:07 +1000 (EST)
Date: Mon, 19 May 2008 15:17:22 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/4] spi: Add OF binding support for SPI busses
In-Reply-To: <20080516193613.28030.13950.stgit@trillian.secretlab.ca>
Message-ID: <Pine.LNX.4.64.0805191446530.27140@axis700.grange>
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
	<20080516193613.28030.13950.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: fabrizio.garetto@gmail.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, dbrownell@users.sourceforge.net,
	spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 16 May 2008, Grant Likely wrote:

> +    However, the binding does not attempt to define the specific method for
> +    assigning chip select numbers.  Since SPI chip select configuration is
> +    flexible and non-standardized, it is left out of this binding with the
> +    assumption that board specific platform code will be used to manage
> +    chip selects.  Individual drivers can define additional properties to
> +    support describing the chip select layout.

Yes, this looks like a problem to me. This means, SPI devices will need 
two bindings - OF and platform?... Maybe define an spi_chipselect 
OF-binding?

Thanks
Guennadi
---
Guennadi Liakhovetski
