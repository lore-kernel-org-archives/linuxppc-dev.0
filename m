Return-Path: <r61911@freescale.com>
Received: from AM1EHSOBE005.bigfish.com (am1ehsobe001.messaging.microsoft.com
 [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 24F7FB6EE8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2012 15:40:32 +1100 (EST)
From: Zang Roy-R61911 <r61911@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Li Yang-R58472
 <r58472@freescale.com>
Subject: RE: [PATCH V2 RESEND] fsl-sata: I/O load balancing
Date: Mon, 20 Feb 2012 04:40:21 +0000
Message-ID: <3E027F8168735B46AC006B1D0C7BB002065A30@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1329284944-17943-1-git-send-email-qiang.liu@freescale.com>
 <1329439216.2892.36.camel@pasglop>
 <94F013E7935FF44C83EBE7784D62AD3F0574273C@039-SN2MPN1-023.039d.mgd.msft.net>
 <1329448724.2892.43.camel@pasglop>
In-Reply-To: <1329448724.2892.43.camel@pasglop>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 Liu Qiang-B32616 <B32616@freescale.com>,
 "jgarzik@pobox.com" <jgarzik@pobox.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: linuxppc-dev-bounces+tie-fei.zang=3Dfreescale.com@lists.ozlabs.org
> [mailto:linuxppc-dev-bounces+tie-fei.zang=3Dfreescale.com@lists.ozlabs.or=
g]
> On Behalf Of Benjamin Herrenschmidt
> Sent: Friday, February 17, 2012 11:19 AM
> To: Li Yang-R58472
> Cc: Liu Qiang-B32616; jgarzik@pobox.com; linuxppc-dev@lists.ozlabs.org;
> linux-kernel@vger.kernel.org; linux-ide@vger.kernel.org
> Subject: RE: [PATCH V2 RESEND] fsl-sata: I/O load balancing
>=20
> On Fri, 2012-02-17 at 03:09 +0000, Li Yang-R58472 wrote:
> > >I tried a debian install on the p5020ds here and I find SATA to be
> > >extremely slow, generating millions of interrupts. I think the
> > defaults
> > >should be a lot more aggressive at coalescing.
> >
> > The P5020 has a hardware problem with SATA, making it generate more
> > interrupts than it should.  A new revision of the silicon will fix it.
>=20
> Ok cool. With a bit of luck you guys can send me a new silicon when it's
> available then :-) (The one in the board you got me seems to be in a
> socket).
Ben,
We still do not have the a P5020 sample to fix the problem.
One workaround is to use the patch ( I think you have noticed the patch):
http://git.freescale.com/git/cgit.cgi/ppc/sdk/linux.git/commit/?id=3D92c0ce=
1e599e788ffc0908739db9bd5e0dbdad69

and  use a SSD hard drive.
It will have a usable performance.
Thanks.
Roy
