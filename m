Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5F7B6DDECD
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 01:46:03 +1000 (EST)
Subject: Re: [PATCH] 86xx: Enable the AC97 interface on 8641D board.
From: Jon Loeliger <jdl@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0705100015570.27791@localhost.localdomain>
References: <1178142818.32136.51.camel@ld0161-tx32>
	<Pine.LNX.4.64.0705100015570.27791@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1178811953.6578.3.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Thu, 10 May 2007 10:45:53 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-05-10 at 00:16, Kumar Gala wrote:
> On Wed, 2 May 2007, Jon Loeliger wrote:
> 
> > From: Jason Jin <jason.jin@freescale.com>
> >
> > HD interface and AC97 interface share some pins and they are enabled at
> > the same time, In order to use AC97 interface, we need to disable the HD
> > interface first.
> >
> 
> applied.
> 
> - k

Thank you!

jdl
