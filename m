Return-Path: <r61911@freescale.com>
Received: from TX2EHSOBE002.bigfish.com (tx2ehsobe002.messaging.microsoft.com
 [65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9B9FAB6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2012 13:10:54 +1100 (EST)
From: Zang Roy-R61911 <r61911@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, Wood Scott-B07421
 <B07421@freescale.com>
Subject: RE: [PATCH 1/2 v2] powerpc/dts: Add dts for p1025rdb board
Date: Wed, 1 Feb 2012 02:10:23 +0000
Message-ID: <3E027F8168735B46AC006B1D0C7BB00203CFE2@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1328003481-31821-1-git-send-email-B32736@freescale.com>
 <DDC3CACD-1B1C-4826-A839-65D42395ACEA@kernel.crashing.org>
 <4F283CB7.4050908@freescale.com>
 <7D155016-AC91-440A-A88F-FEEF85C13184@kernel.crashing.org>
In-Reply-To: <7D155016-AC91-440A-A88F-FEEF85C13184@kernel.crashing.org>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Fan Zhicheng-B32736 <B32736@freescale.com>,
 Zhicheng Fan <b32736@freeescale.com>
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
> On Behalf Of Kumar Gala
> Sent: Wednesday, February 01, 2012 7:44 AM
> To: Wood Scott-B07421
> Cc: linuxppc-dev@lists.ozlabs.org; Zhicheng Fan; Fan Zhicheng-B32736
> Subject: Re: [PATCH 1/2 v2] powerpc/dts: Add dts for p1025rdb board
>=20
>=20
> On Jan 31, 2012, at 1:10 PM, Scott Wood wrote:
>=20
> > On 01/31/2012 09:55 AM, Kumar Gala wrote:
> >>
> >> On Jan 31, 2012, at 3:51 AM, Zhicheng Fan wrote:
> >>> Signed-off-by: Zhicheng Fan <b32736@freeescale.com>
> >>> ---
> >>> arch/powerpc/boot/dts/fsl/p1025si-post.dtsi |  228
> +++++++++++++++++++++
> >>> arch/powerpc/boot/dts/fsl/p1025si-pre.dtsi  |   70 +++++++
> >>> arch/powerpc/boot/dts/p1025rdb.dts          |  137 +++++++++++++
> >>> arch/powerpc/boot/dts/p1025rdb.dtsi         |  286
> +++++++++++++++++++++++++++
> >>> arch/powerpc/boot/dts/p1025rdb_36b.dts      |   88 ++++++++
> >>> 5 files changed, 809 insertions(+), 0 deletions(-)
> >>> create mode 100644 arch/powerpc/boot/dts/fsl/p1025si-post.dtsi
> >>> create mode 100644 arch/powerpc/boot/dts/fsl/p1025si-pre.dtsi
> >>> create mode 100644 arch/powerpc/boot/dts/p1025rdb.dts
> >>> create mode 100644 arch/powerpc/boot/dts/p1025rdb.dtsi
> >>> create mode 100644 arch/powerpc/boot/dts/p1025rdb_36b.dts
> >>
> >> For the p1024 & p1025 I do NOT want to add new dts/fsl/p1025si*.dtsi
> files.  We should use the p1020 and p1021 as they are identical.
> >
> > Are they sufficiently software compatible that we want to use
> > p1020/p1021 in all the compatible strings?  If yes, how was this verifi=
ed?
>=20
> They are the identical silicon just in different physical packages.  It w=
as
> verified by me asking the FSL marketing team.
>=20
> I'll work up a patch to add some comments to the p1020 & p1021si dts file=
s
> about being the same for p1024/p1025.
Should we expose the information "p1024/p1025 are identical to p1020/p1021"=
 to our customer?
Thanks.
Roy
