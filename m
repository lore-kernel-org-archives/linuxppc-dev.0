Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 03B03DDE25
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Nov 2007 04:06:26 +1100 (EST)
Date: Wed, 31 Oct 2007 12:06:10 -0500
From: Scott Wood <scottwood@freescale.com>
To: Yoder Stuart-B08248 <stuart.yoder@freescale.com>
Subject: Re: RFC:  replace device_type with new "class" property?
Message-ID: <20071031170610.GA4444@loki.buserror.net>
References: <9696D7A991D0824DBA8DFAC74A9C5FA30359F9BB@az33exm25.fsl.freescale.net>
	<20071029212213.GA28073@lixom.net>
	<20071030005146.GF29263@localhost.localdomain>
	<9696D7A991D0824DBA8DFAC74A9C5FA3035F26EE@az33exm25.fsl.freescale.net>
	<20071030232730.GD2784@localhost.localdomain>
	<9696D7A991D0824DBA8DFAC74A9C5FA3035F2AC3@az33exm25.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA3035F2AC3@az33exm25.fsl.freescale.net>
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

On Wed, Oct 31, 2007 at 08:31:02AM -0700, Yoder Stuart-B08248 wrote:
> This works...but certainly is weaker with respect to
> standardization.  My previous argument had the assumption
> that something like "mac-address" in a network node was
> _required_, and thus needed a class id of some sort to tie
> the standardized node to.

It is certainly not required -- the device could have an eeprom, or it might
not be ethernet at all.

-Scott
