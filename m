Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 74A7167DB5
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jul 2005 01:59:53 +1000 (EST)
Date: Wed, 27 Jul 2005 08:59:51 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: John Otken <jotken@softadvances.com>
Message-ID: <20050727155950.GA28681@gate.ebshome.net>
References: <42E776DD.9080307@softadvances.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <42E776DD.9080307@softadvances.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] Support for AMCC Yosemite 440EP Eval Board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jul 27, 2005 at 06:58:21AM -0500, John Otken wrote:
> This patch adds support for the new AMCC Yosemite 440EP Eval
> Board.  I tested it on the both Bamboo and Yosemite boards
> using the 2.6.12 kernel.
> 
> This patch has three dependencies:
> 2005-04-07 Wade Farnsworth's PPC440EP SoC and Bamboo board support

Why this old one? Updated patch was posted yesterday.

> 2005-07-20 My fix invalid function name usb_hcd_put in ohci-ppc-soc.c
> 2005-07-27 My Support 440EP On-Chip OHCI USB Host Controller
> 
> http://patchwork.ozlabs.org/linuxppc/patch?id=1311
> http://patchwork.ozlabs.org/linuxppc/patch?id=1803
> http://patchwork.ozlabs.org/linuxppc/patch?id=1855
> 
> Comments are welcome.

Well, why don't you make separate board port instead if hacking 
Bamboo one? 

IMHO, direction you are going is creating a lot of mess. If there is 
some common parts between Bamboo and Yosemite, the right way is to 
factor out this stuff from Bamboo port.

Also, your patch is mangled - some lines are wrapped.

-- 
Eugene
