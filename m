Return-Path: <greg@kroah.com>
Received: from perch.kroah.org (mail.kroah.org [69.55.234.183])
	by ozlabs.org (Postfix) with ESMTP id 0D9E467A6D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Mar 2005 05:59:28 +1100 (EST)
Date: Wed, 9 Mar 2005 10:59:04 -0800
From: Greg KH <greg@kroah.com>
To: Kumar Gala <galak@freescale.com>
Message-ID: <20050309185904.GF27268@kroah.com>
References: <Pine.LNX.4.61.0503041303290.18551@blarg.somerset.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.61.0503041303290.18551@blarg.somerset.sps.mot.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] ppc32: trivial fix for e500 oprofile build
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Mar 04, 2005 at 01:09:18PM -0600, Kumar Gala wrote:
> Andrew, Greg
> 
> Here is a patch for the new 2.6.11 release tree and for Linus.
> 
> Fix for trivial fix for 2.6.11 oprofile compilation on e500 based ppc.
> 
> Signed-off-by: Andy Fleming <afleming@freescale.com>
> Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

Added to the -stable queue, thanks.

greg k-h
