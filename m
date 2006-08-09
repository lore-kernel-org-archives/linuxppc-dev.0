Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id C895567B9C
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Aug 2006 21:30:28 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k79BUQwD005561
	for <linuxppc-embedded@ozlabs.org>; Wed, 9 Aug 2006 04:30:26 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k79BUNlI022605
	for <linuxppc-embedded@ozlabs.org>; Wed, 9 Aug 2006 06:30:25 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Trouble on building crossover compiler for Synology 8041 PPCbased
	NAS
Date: Wed, 9 Aug 2006 19:30:50 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D0B34EB@zch01exm20.fsl.freescale.net>
In-Reply-To: <44D8C02D.1070205@ovro.caltech.edu>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "David Hawkins" <dwh@ovro.caltech.edu>,
	"chun fung siu" <vows_siu@yahoo.com.hk>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

http://images.tomshardware.com/2006/06/28/not_going_wrong_with_the_synol
ogy_ds/synology_ds106e_main_board_big.jpg

Here is a picture of the exact model.  I can confirm that it's a
MPC8241.

Best Regards,
Leo
> -----Original Message-----
> From: linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org
> [mailto:linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org] On
Behalf Of
> David Hawkins
> Sent: Wednesday, August 09, 2006 12:48 AM
> To: chun fung siu
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: Trouble on building crossover compiler for Synology 8041
PPCbased NAS
>=20
> chun fung siu wrote:
> > Hi,
> >
> > I recently bought a Synology Network Attached Server DS-106e, run
using
> > a "Linux 2. 4.22-uc-0" Kernel, under 8041 PPC, no "gcc" installed. I
> > want to build a crosslink gcc compiler for it in another "debian 2.6
> > kernel" linux. I find many options in the crosslink build script on
ppc,
> > but can't find any option for 8041 PPC. So what option should I
choose?
> > And further can I put the artifacts just compiled in my Network
Attached
> > Server? So that I can compile anything directly in my NAS.
>=20
> The processor is probably an *MPC8241*.
>=20
> The DS101g is also an MPC8241. So this should provide you with
> some useful info:
>=20
> http://www.nslu2-linux.org/wiki/DS101/HomePage
> http://www.nslu2-linux.org/wiki/DS101/DS101GHardware
>=20
> Dave
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
