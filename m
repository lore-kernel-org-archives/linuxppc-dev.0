Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B9F0DDE00B
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 05:09:38 +1100 (EST)
Message-ID: <47ED3441.3090601@freescale.com>
Date: Fri, 28 Mar 2008 13:09:05 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2 v4] Driver for Freescale 8610 and 5121 DIU
References: <12066720572512-git-send-email-yorksun@freescale.com>
	<12066720572314-git-send-email-yorksun@freescale.com>
	<47ED2B35.4030601@freescale.com> <47ED33C6.3090202@freescale.com>
In-Reply-To: <47ED33C6.3090202@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linux-fbdev-devel@lists.sourceforge.net, a.p.zijlstra@chello.nl,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	akpm@linux-foundation.org, York Sun <yorksun@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> Scott Wood wrote:
> 
>> ...but not anywhere else.  All user pointers should have a __user 
>> annotation.
> 
> Even in a typecast?

Yes.  Otherwise, as far as sparse sees, you're passing a kernel pointer 
to something expecting a user pointer.

-Scott
