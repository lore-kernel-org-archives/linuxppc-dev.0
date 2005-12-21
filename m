Return-Path: <ak@muc.de>
Received: from mail.muc.de (colin.muc.de [193.149.48.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "", Issuer "muc.de e.V." (not verified))
	by ozlabs.org (Postfix) with ESMTP id 178356890D
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Dec 2005 06:37:13 +1100 (EST)
Date: 21 Dec 2005 20:37:09 +0100
Date: Wed, 21 Dec 2005 20:37:09 +0100
From: Andi Kleen <ak@muc.de>
To: Simon Richter <Simon.Richter@hogyros.de>
Message-ID: <20051221193709.GA49171@muc.de>
References: <20051221121201.GA54164@muc.de> <43A95FE5.8060504@hogyros.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <43A95FE5.8060504@hogyros.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Don't allow CONFIG_PMAC_BACKLIGHT on pmac64
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 21, 2005 at 03:00:05PM +0100, Simon Richter wrote:
> Hi,
> 
> Andi Kleen wrote:
> 
> >Don't allow to set CONFIG_MAC_BACKLIGHT on pmac64. It won't compile.
> 
> > -	depends on ADB_PMU && (BROKEN || !PPC64)
> > +	depends on ADB_PMU && !PPC64
> 
> That's why it's marked BROKEN, perhaps?

It didn't work - i could select it.

-Andi
