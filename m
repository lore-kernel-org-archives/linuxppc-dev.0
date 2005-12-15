Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (sipsolutions.net [66.160.135.76])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9A38B68802
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Dec 2005 20:40:36 +1100 (EST)
Message-ID: <4576.131.234.232.31.1134639623.squirrel@secure.sipsolutions.net>
In-Reply-To: <9892D605-1B30-4094-AEEC-9DA6F3B13B05@freescale.com>
References: <1134569118.3875.9.camel@localhost>
	<9892D605-1B30-4094-AEEC-9DA6F3B13B05@freescale.com>
Date: Thu, 15 Dec 2005 10:40:23 +0100 (CET)
From: "Johannes Berg" <johannes@sipsolutions.net>
To: "Andy Fleming" <afleming@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-15
Cc: linuxppc-dev@ozlabs.org
Subject: Re: illegal instructions / irqs disabled warning
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andy Fleming wrote:

> What platform is this on?  The copy from user stuff is a bit out of
> my area of expertise, but I've got an implementation of backtrace for
> oprofile running on 85xx.  Mostly, it's just a hacked up version of
> the ppc64 patch that was floating around.

ppc32, compiling the kernel with ARCH=ppc still.

johannes
