Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AD92E2C02A5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 02:50:40 +1000 (EST)
Date: Wed, 19 Jun 2013 11:50:30 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: Pull request: scottwood/linux.git for-3.10
To: Kumar Gala <galak@kernel.crashing.org>
References: <20130618201452.GA5429@home.buserror.net>
 <AEF681B9-AB7E-4C3D-99D6-BD29EF038A50@kernel.crashing.org>
In-Reply-To: <AEF681B9-AB7E-4C3D-99D6-BD29EF038A50@kernel.crashing.org>
 (from galak@kernel.crashing.org on Wed Jun 19 10:06:38 2013)
Message-ID: <1371660630.9073.34@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/19/2013 10:06:38 AM, Kumar Gala wrote:
>=20
> On Jun 18, 2013, at 3:14 PM, Scott Wood wrote:
>=20
> > This fixes a regression that causes 83xx to oops on boot if a
> > non-express PCI bus is present.
> >
> > The following changes since commit =20
> 17858ca65eef148d335ffd4cfc09228a1c1cbfb5:
> >
> >  Merge tag 'please-pull-fixia64' of =20
> git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux (2013-06-18 =20
> 06:29:19 -1000)
> >
> > are available in the git repository at:
> >
> >
> >  git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git =20
> for-3.10
> >
> > for you to fetch changes up to =20
> 2383ea94854bcf5a0df3c6803b980868cef95418:
> >
> >  powerpc/pci: Fix setup of Freescale PCI / PCIe controllers =20
> (2013-06-18 14:44:57 -0500)
> >
> > ----------------------------------------------------------------
> > Rojhalat Ibrahim (1):
> >      powerpc/pci: Fix setup of Freescale PCI / PCIe controllers
> >
> > arch/powerpc/sysdev/fsl_pci.c |   24 +++++++++---------------
> > 1 file changed, 9 insertions(+), 15 deletions(-)
>=20
> What about Rohit's patch: powerpc/pci: Fix setup of Freescale PCI / =20
> PCIe controllers?  Seems like also a fix for 3.10

That's the patch I'm asking you to pull. :-P

-Scott=
