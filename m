Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BEE27DDF59
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Sep 2008 18:12:30 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m828CMQx010413
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Sep 2008 01:12:22 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m828CKqZ005810
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Sep 2008 03:12:21 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] usb: add Freescale QE/CPM USB peripheral controllerdriver
Date: Tue, 2 Sep 2008 16:12:17 +0800
Message-ID: <0C69E0CDED15E4469A445DE244C1B9F708CEE6@zch01exm26.fsl.freescale.net>
In-Reply-To: <1220342239.7762.14.camel@gentoo-jocke.transmode.se>
References: <1219916613-28827-1-git-send-email-leoli@freescale.com>
	<20080901171106.GA13447@oksana.dev.rtsoft.ru>
	<2a27d3730809020035o52d1feepcde60516c607dac6@mail.gmail.com>
	<1220342239.7762.14.camel@gentoo-jocke.transmode.se>
From: "Li Yang-R58472" <LeoLi@freescale.com>
To: <joakim.tjernlund@transmode.se>
Cc: dbrownell@users.sourceforge.net, greg@kroah.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Joakim Tjernlund [mailto:joakim.tjernlund@transmode.se]=20
> Sent: Tuesday, September 02, 2008 3:57 PM
> To: Li Yang-R58472
> Cc: avorontsov@ru.mvista.com; greg@kroah.com;=20
> linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org;=20
> dbrownell@users.sourceforge.net; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] usb: add Freescale QE/CPM USB peripheral=20
> controllerdriver
>=20
> On Tue, 2008-09-02 at 15:35 +0800, Li Yang wrote:
> > On Tue, Sep 2, 2008 at 1:11 AM, Anton Vorontsov=20
> > <avorontsov@ru.mvista.com> wrote:
> > > On Thu, Aug 28, 2008 at 05:43:33PM +0800, Li Yang wrote:
> > >> Some of Freescale SoC chips have a QE or CPM co-processor which=20
> > >> supports full speed USB.  The driver adds device mode support of=20
> > >> both QE and CPM USB controller to Linux USB gadget.  The=20
> driver is=20
> > >> tested with MPC8360 and MPC8272, and should work with=20
> other models=20
> > >> having QE/CPM given minor tweaks.
> > >>
> > >> Signed-off-by: Xie Xiaobo <X.Xie@freescale.com>
> > >> Signed-off-by: Li Yang <leoli@freescale.com>
> > >> ---
> > >> This is the second submission of the driver.  This=20
> version addressed:
> > >> Comments from Anton Vorontsov.
> > >> A lot of cosmetic problem.
> > >> Sparse and various kernel DEBUG warnings.
> > >
> > > Just caught this:
> > >
> > > g_ether gadget: high speed config #1: CDC Ethernet (ECM)
>=20
> Does RNDIS work too? If not, is it possible to add or doesn't=20
> the HW support it?

RNDIS is a gadget(protocol) level thing.  I believe it can work with
this driver although not tested myself.

Noted:  AFAIK, RNDIS gadget in Linux doesn't interoperate with windows
well enough to be production level.  Use at your own risk.

- Leo
