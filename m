Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 138C3DDED1
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 04:00:41 +1000 (EST)
Message-ID: <4703D8B9.5080006@freescale.com>
Date: Wed, 03 Oct 2007 13:00:25 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [PATCH v4] qe: miscellaneous code improvements and fixes to the
	QE library
References: <1191429299378-git-send-email-timur@freescale.com>
	<20071003094449.702c4a90@freepuppy.rosehill>
In-Reply-To: <20071003094449.702c4a90@freepuppy.rosehill>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Hemminger wrote:

> Separate the changes into individual patches to allow for better comment/review
> and bisection in case of regression.

That would be too difficult.  Some of the changes are single lines, and this 
patch has already been approved -- I just cross-posted to netdev because I 
made a few ucc_geth changes that can't be docoupled from the powerpc changes. 
  A series of 18 patches would just be convoluted.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
