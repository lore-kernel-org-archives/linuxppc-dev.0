Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 27B15DDE47
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 01:15:29 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/3] 82xx: Parse SMC serial device node in DTS
Date: Tue, 17 Jul 2007 16:22:38 +0200
References: <469B33F9.2080604@windriver.com> <200707171406.03455.arnd@arndb.de>
	<3D0E2A2D-9ADE-4931-9C73-8E65550C728F@kernel.crashing.org>
In-Reply-To: <3D0E2A2D-9ADE-4931-9C73-8E65550C728F@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707171622.38496.arnd@arndb.de>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 17 July 2007, Segher Boessenkool wrote:
> > If the compatible property contains "fsl,cpm-smc\0cpm_uart", you =A0
> > can scan for
> > either of them. The loop will iterate over all cpm_uart compatible =A0
> > devices,
> > while the later test will look for an fsl,cpm-smc compatible device.
>=20
> Well, "fsl,cpm-uart" (note the two differences), but yes.

My point was about the 'smc' part that needs to be added, so I guess
if we want to have that in there, it should be "fsl,cpm-smc-uart"
really, and "fsl,cpm-scc-uart", respectively.

	Arnd <><
