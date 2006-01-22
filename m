Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5CB3C68A02
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jan 2006 08:59:16 +1100 (EST)
Subject: Re: [PATCH 001/001] PMAC HD runtime blinking control
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
In-Reply-To: <200601221256.25685.arekm@pld-linux.org>
References: <20060122121907.792abc72.cedric.pradalier@free.fr>
	<200601221256.25685.arekm@pld-linux.org>
Content-Type: text/plain
Date: Mon, 23 Jan 2006 08:59:21 +1100
Message-Id: <1137967161.4907.2.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2006-01-22 at 12:56 +0100, Arkadiusz Miskiewicz wrote:
> On Sunday 22 January 2006 03:19, Cedric Pradalier wrote:
> > Hi,
> >
> > I've finally spend the time to mend the patch for control of
> > the HD led blinking at runtime. This is a patch against
> > 2.6.15
> 
> I wonder if it's also possible to disable blinking when laptop sleeps?

Not that I know.. this is entirely done by the PMU.

Ben.
