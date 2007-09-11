Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E5D5ADDEC7
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 23:57:33 +1000 (EST)
Date: Tue, 11 Sep 2007 08:57:17 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/3] fsl_soc.c cleanup
Message-ID: <20070911135717.GD1932@ld0162-tx32.am.freescale.net>
References: <20070828201618.GA24210@ld0162-tx32.am.freescale.net>
	<1E0D95DC-03E8-4BF0-9E22-69AECFA73FCF@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1E0D95DC-03E8-4BF0-9E22-69AECFA73FCF@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 11, 2007 at 12:35:56AM -0500, Kumar Gala wrote:
> 
> On Aug 28, 2007, at 3:16 PM, Scott Wood wrote:
> 
> >1. Fix get_immrbase() to use ranges, rather than reg.
> >
> >It is not always the case that the SoC's first reg property points
> >to the beginning of the entire SoC block.
> 
> when is this true?

The intent was to eliminate the need for the reg property in /soc.

> Upon further testing this breaks some platforms.  I don't think  
> assuming the first range entry is mapping to the SOC register space  
> is a good idea.

Let me guess, 8544ds and 8548cds?  Because of the same recent ranges
changes that we were arguing about in another thread? :-P

-Scott
