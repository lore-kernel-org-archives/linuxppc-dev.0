Return-Path: <stuart.yoder@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 8DB49DDEC6
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 08:08:02 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l1CL7xmo004493
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Feb 2007 14:07:59 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l1CL7sQU017878
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Feb 2007 15:07:58 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC] mpc5200 device tree bindings refinement
Date: Mon, 12 Feb 2007 14:07:14 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA302942900@az33exm25.fsl.freescale.net>
In-Reply-To: <528646bc0702121244k6e2878behb935cdbb3d249039@mail.gmail.com>
References: <11710062092006-git-send-email-grant.likely@secretlab.ca>
	<9696D7A991D0824DBA8DFAC74A9C5FA3029428D5@az33exm25.fsl.freescale.net>
	<528646bc0702121244k6e2878behb935cdbb3d249039@mail.gmail.com>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: glikely@gmail.com [mailto:glikely@gmail.com] On Behalf=20
> Of Grant Likely
> Sent: Monday, February 12, 2007 2:44 PM

[snip]

> I'm not too concerned about the name of this property.  It's pretty
> much SoC specific regardless.  Every time a new soc is rolled, there
> will be differences in how the frequency properties are interpreted.
> In this case, this is not the external clock frequency, but rather the
> internal frequency derived from the external clock.  I thought it best
> to name the property after the actual signal name (fsystem).  Maybe it
> would be best to rename this to "fsl,system-frequency" or
> "fsl,fsystem-frequency"

I think "fsl,fsystem-frequency" is good.  It is clear that it is
not a general soc property and identifies a specific clock.

Stuart
