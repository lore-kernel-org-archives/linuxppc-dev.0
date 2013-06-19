Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8C27B2C02A6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 01:06:58 +1000 (EST)
Subject: Re: Pull request: scottwood/linux.git for-3.10
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20130618201452.GA5429@home.buserror.net>
Date: Wed, 19 Jun 2013 10:06:38 -0500
Message-Id: <AEF681B9-AB7E-4C3D-99D6-BD29EF038A50@kernel.crashing.org>
References: <20130618201452.GA5429@home.buserror.net>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 18, 2013, at 3:14 PM, Scott Wood wrote:

> This fixes a regression that causes 83xx to oops on boot if a
> non-express PCI bus is present.
>=20
> The following changes since commit =
17858ca65eef148d335ffd4cfc09228a1c1cbfb5:
>=20
>  Merge tag 'please-pull-fixia64' of =
git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux (2013-06-18 =
06:29:19 -1000)
>=20
> are available in the git repository at:
>=20
>=20
>  git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git =
for-3.10
>=20
> for you to fetch changes up to =
2383ea94854bcf5a0df3c6803b980868cef95418:
>=20
>  powerpc/pci: Fix setup of Freescale PCI / PCIe controllers =
(2013-06-18 14:44:57 -0500)
>=20
> ----------------------------------------------------------------
> Rojhalat Ibrahim (1):
>      powerpc/pci: Fix setup of Freescale PCI / PCIe controllers
>=20
> arch/powerpc/sysdev/fsl_pci.c |   24 +++++++++---------------
> 1 file changed, 9 insertions(+), 15 deletions(-)

What about Rohit's patch: powerpc/pci: Fix setup of Freescale PCI / PCIe =
controllers?  Seems like also a fix for 3.10

- k=
