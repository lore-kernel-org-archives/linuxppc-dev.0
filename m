Return-Path: <linville@tuxdriver.com>
Received: from ra.tuxdriver.com (ra.tuxdriver.com [24.172.12.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 51030689D0
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jan 2006 09:03:49 +1100 (EST)
Date: Wed, 11 Jan 2006 16:52:21 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Gerhard Pircher <gerhard_stamer@gmx.net>
Message-ID: <20060111215218.GF27985@tuxdriver.com>
References: <6063.1137013232@www88.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6063.1137013232@www88.gmx.net>
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
Subject: Re: AGPGART driver for ArticiaS - ioremap() problem
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 11, 2006 at 10:00:32PM +0100, Gerhard Pircher wrote:

> David Bentam and I are trying to get a AGPGART driver working for the
> AmigaOne and the Pegasos1. The driver detects the aperture size of the
> ArticiaS AGP bridge, but fails at the ioremap() function in the generic GATT
> table create function. Does the PowerPC platform behaves differently for the
> mapping of address location for AGP operation than the x86 platform? Is it
> possible to use a mask to relocate the AGP address space to a specific
> location?

It probably wouldn't hurt to include the source (or a url pointing
to it)... :-)

John
-- 
John W. Linville
linville@tuxdriver.com
