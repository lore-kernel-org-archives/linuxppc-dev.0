Return-Path: <SSparks@aclaratech.com>
Received: from SG2EHSOBE004.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80]) by ozlabs.org (Postfix) with ESMTP id 67D89DE207
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 03:50:58 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: mpc8349-mITX DTB load failure
Date: Mon, 28 Jul 2008 12:49:19 -0500
Message-ID: <6011A7C9CD0EE74792C3ED2A8355608634214C@mail.twacs.com>
In-Reply-To: <20080728171634.GB21265@secretlab.ca>
References: <6011A7C9CD0EE74792C3ED2A8355608634213E@mail.twacs.com>
	<20080728171634.GB21265@secretlab.ca>
From: "Sparks, Sam" <SSparks@aclaratech.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> From: Grant Likely
> Sent: Monday, July 28, 2008 12:17 PM
>=20
> On Mon, Jul 28, 2008 at 11:10:47AM -0500, Sparks, Sam wrote:
> > Hello All,
> >=20
> > I am trying to boot the mpc8349-mITX board with Compact=20
> flash support,=20
> > and am unable to boot the Linux kernel. Here is the pertinant=20
> > versioning
> > information:
> > DTC 1.2.0-rc2-g17773b0e
> > U-Boot 1.3.4-rc1-00012-g1953d12
> > Linux-2.6.26-05752-g93ded9b
> >=20
> > I've built the DTB using the following two commands -=20
> neither change=20
> > the error I get during boot-up.
> > $ ../dtc/dtc -b 0 -I dts -O dtb -R 4 -S 0x3000 -o=20
> > /tftproot/ssparks/itx/cf2/itx.dtb -V 17=20
> > arch/powerpc/boot/dts/mpc8349emitx.dts
> > $ ../dtc/dtc -I dts -O dtb -o /tftproot/ssparks/itx/cf2/itx2.dtb
> > arch/powerpc/boot/dts/mpc8349emitx.dts
>=20
> Try adding "-p 0x3000" to ensure that you get padding to the blob.
>=20
> g.
>=20

No luck there, either. I ran into a issue with space a year ago, and was
getting the FDT_ERR_NOSPACE error until I added the -S 0x3000 option.
This looks like something completely different.

Thanks tho,
Sam
