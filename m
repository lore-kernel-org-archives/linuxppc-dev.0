Return-Path: <DusharaJ@optiscan.com>
Received: from mail.optiscan.com (mail.optiscan.com [203.26.112.1])
	by ozlabs.org (Postfix) with ESMTP id 06D6ADDDF6
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Feb 2009 14:47:13 +1100 (EST)
From: Dushara Jayasinghe <DusharaJ@optiscan.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Date: Tue, 24 Feb 2009 14:47:12 +1100
Subject: RE: soc vs localbus for flash in device tree
Message-ID: <DE0CCFFBFF707949BEABD4537A14ACBA0C04B4055B@mailsvr>
References: <DE0CCFFBFF707949BEABD4537A14ACBA0C04B40559@mailsvr>
	<20090224000641.GB578@ovro.caltech.edu>
In-Reply-To: <20090224000641.GB578@ovro.caltech.edu>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: 'Michael Bergandi' <mbergandi@gmail.com>,
	'Ira Snyder' <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > Does the flash node HAVE to be within a localbus node or can it
> reside within the soc node? I've been basing my work on mpc834x_mds.dts
> > And hence haven't defined a localbus node.
> >
>=20
> I'm also working on a custom board based on MPC8349EMDS, and have based
> my dts off of mpc834x_mds.dts. I've added the localbus node with my
> chipselects and flash. It works, but there are no guarantees of
> correctness.
>=20

This worked for me. Thanks.

D
