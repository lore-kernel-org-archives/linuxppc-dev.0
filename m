Return-Path: <Clive.Jenkins@xerox.com>
Received: from USA7109MR003.ACS-INC.COM (usa7109mr003.acs-inc.com
	[63.101.151.12])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(Client CN "usa7109mr.acs-inc.com",
	Issuer "GeoTrust DV SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7B68BB6FCC
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Jun 2011 20:52:04 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] fsl-diu-fb: remove the ioctl interface
Date: Wed, 22 Jun 2011 11:39:49 +0100
Message-ID: <929D3CED81F34E43887A393170D66FB90484A280@GBRSUN01MS002.eu.xerox.net>
In-Reply-To: <20110622003853.1041385c@wker>
References: <1308691655-3416-1-git-send-email-timur@freescale.com>
	<20110622003853.1041385c@wker>
From: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
To: "Anatolij Gustschin" <agust@denx.de>,
	"Timur Tabi" <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-fbdev@vger.kernel.org, lethal@linux-sh.org,
	yorksun@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > The ioctl interface in the Freescale DIU framebuffer driver is just
a
> > collection of miscellaneous functions which were only used in a
one-time
> > demo application that was never distributed.  Plus, the ioctls were
spread
> > across two types (both conflicting), and the demo app didn't even
use all
> > of them.
> >=20
> > Removing the ioctl interface also allows us to clean up the header
file and
> > remove other unusued stuff.
>=20
> No! We are using ioctl interface of this driver in many video
> rendering applications on overlay planes on huge number of boards.
> So, please don't remove it.
>=20
> Anatolij

Can you make available your application code by posting a link to it?

Thanks,
Clive
