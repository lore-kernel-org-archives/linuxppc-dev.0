Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BD7D7DE07A
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Dec 2007 02:53:58 +1100 (EST)
Date: Fri, 14 Dec 2007 09:53:41 -0600
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/3] mpc82xx: Embedded Planet EP8248E support
Message-ID: <20071214155341.GB16269@ld0162-tx32.am.freescale.net>
References: <20071211212247.GB3620@loki.buserror.net>
	<EB293853-B27A-4B0E-AEEB-8D3F09E8F12D@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <EB293853-B27A-4B0E-AEEB-8D3F09E8F12D@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 13, 2007 at 11:19:33PM -0600, Kumar Gala wrote:
> Can we make this a /dts-v1/; since its new.

It's not really new; it's just been collecting dust for a while. :-P

Are there any tools to autoconvert (preferably without losing comments)?

> >+/ {
> >+	model = "EP8248E";
> >+	compatible = "fsl,ep8248e";
> >+	#address-cells = <1>;
> >+	#size-cells = <1>;
> 
> Add a aliases { } and can we use that instead of linux,network-index  
> and linux,planetcore-label.

I don't see any support in the current bootwrapper for aliases.

-Scott
