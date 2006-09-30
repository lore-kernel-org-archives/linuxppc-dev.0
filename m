Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id C67B667BC1
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Sep 2006 14:36:41 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k8U5uerh005719
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 23:56:40 -0600 (MDT)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k8U4aaUK023495
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 23:36:38 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 6/9] qe_lib: Add QE SoC support
Date: Sat, 30 Sep 2006 12:37:15 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D19DB0D@zch01exm20.fsl.freescale.net>
In-Reply-To: <46197B66-B634-444C-B63D-115CDD15F1B7@kernel.crashing.org>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Friday, September 29, 2006 10:13 PM
> To: Li Yang-r58472
> Cc: paulus@samba.org; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH 6/9] qe_lib: Add QE SoC support
>=20
>=20
> On Sep 29, 2006, at 5:35 AM, Li Yang wrote:
>=20
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> >
> > ---
> >  arch/powerpc/sysdev/qe_lib/qe.c |  176 ++++++++++++++++++++++++++++
> > +++++++++++
> >  include/linux/fsl_devices.h     |   39 ++++++++-
> >  2 files changed, 214 insertions(+), 1 deletions(-)
>=20
> As I've stated in the past make this use of_device instead of
> platform_device.

As I've argued before, there are currently many off-the-tree user of ppc
arch on 8360, and we must still support that.  Change the ucc_geth
driver to use of_device will add the effort of maintaining two versions
of ucc_geth driver for us (one for ppc, one for powerpc).  Do you really
think it is so important to replace platform_device with of_device?  I
didn't see any true benefit of doing so.

- Leo
