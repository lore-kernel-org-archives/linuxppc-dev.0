Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F0E00DDEEE
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 09:11:48 +1100 (EST)
Date: Tue, 8 Jan 2008 16:11:39 -0600
From: Scott Wood <scottwood@freescale.com>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH 1/3 v2] Add StorCenter DTS first draft.
Message-ID: <20080108221139.GA5599@loki.buserror.net>
References: <E1JCMb2-0002mG-LK@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1JCMb2-0002mG-LK@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 08, 2008 at 04:06:56PM -0600, Jon Loeliger wrote:
> +/ {
> +	model = "StorCenter";
> +	compatible = "storcenter";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +        aliases {
> +                serial0 = &serial0;
> +                serial1 = &serial1;
> +                pci0 = &pci0;
> +        };

These should be tabs, not spaces.  Likewise in some other parts of the file.

-Scott
