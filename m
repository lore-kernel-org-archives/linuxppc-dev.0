Return-Path: <msm@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id EB52D67AC7
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Jun 2006 06:35:30 +1000 (EST)
Subject: Re: [PATCH] Provide mechanism for editing builtin command-line in
	zImage binary.
From: Matthew McClintock <msm@freescale.com>
To: Michal Ostrowski <mostrows@watson.ibm.com>
In-Reply-To: <1149107204.6507.97.camel@brick>
References: <11489544631499-git-send-email-mostrows@watson.ibm.com>
	<20060530204151.GA31567@mag.az.mvista.com>
	<1149023558.6507.15.camel@brick>
	<20060531200419.GA17052@mag.az.mvista.com>
	<1149107204.6507.97.camel@brick>
Content-Type: text/plain
Date: Wed, 31 May 2006 15:35:18 -0500
Message-Id: <1149107718.8379.48.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-05-31 at 16:26 -0400, Michal Ostrowski wrote:
> I've had some experience with trying to edit existing OF trees (i.e.
> take a G5 OF tree and alter it to reflect the fact that the OS has a
> hypervisor between it and the HW).  It's not a pleasant experience.
> 
> Thus for OF based systems I'd be very wary of trying to edit the OF
> tree
> in arbitrary ways prior to Linux seeing it. 

Out of curiosity what was hard about it? Also it is worth mentioning
some systems don't have to privilege of having a OF tree ready to go by
the time Linux starts.

-Matthew
