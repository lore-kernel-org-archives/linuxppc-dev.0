Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id 1ED83B70E3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Feb 2011 20:05:31 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP
	id 12265-06 for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Feb 2011 09:05:12 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 1/2] misc: add CARMA DATA-FPGA Access Driver
Date: Thu, 10 Feb 2011 09:02:47 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AC47@saturn3.aculab.com>
In-Reply-To: <20110210003935.GA6034@core.coreip.homeip.net>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
	"Ira W. Snyder" <iws@ovro.caltech.edu>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> > I was completely unaware of that "feature". I hunch that many
drivers
> > are incapable of dealing with an unbind while they are still open.
>=20
> Hmm, maybe older drivers... Anythig hotpluggable (USB, PCI, etc)
should
> be in a better shape because they expect to be yanked at any time.

Whim and prayer ???

	David
