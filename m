Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 87BF1DE399
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 03:35:13 +1100 (EST)
Date: Tue, 30 Oct 2007 11:33:43 -0500
From: Scott Wood <scottwood@freescale.com>
To: Yoder Stuart-B08248 <stuart.yoder@freescale.com>
Subject: Re: RFC:  replace device_type with new "class" property?
Message-ID: <20071030163343.GA4517@loki.buserror.net>
References: <9696D7A991D0824DBA8DFAC74A9C5FA30359F9BB@az33exm25.fsl.freescale.net>
	<20071029212213.GA28073@lixom.net>
	<20071030005146.GF29263@localhost.localdomain>
	<9696D7A991D0824DBA8DFAC74A9C5FA3035F278B@az33exm25.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA3035F278B@az33exm25.fsl.freescale.net>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 30, 2007 at 09:23:14AM -0700, Yoder Stuart-B08248 wrote:
>   mpic: pic@40000 {
>      clock-frequency = <0>;
>      interrupt-controller;
>      #address-cells = <0>;
>      #interrupt-cells = <2>;
>      reg = <40000 40000>;
>      compatible = "fsl,xyz";
>      big-endian;
> }
> 
> Note-- I removed the device_type property and changed
> compatible somewhat.  How are you going to find where
> the meaning interrupt controller's interrupt cells are
> defined?   What spec will you look at?

The binding for fsl,xyz.

-Scott
