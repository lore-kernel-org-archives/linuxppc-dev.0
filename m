Return-Path: <r61911@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe004.messaging.microsoft.com [213.199.154.142])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9F91CB6EEE
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2012 18:56:04 +1100 (EST)
From: Zang Roy-R61911 <r61911@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, Zhao Chenhui-B35336
 <B35336@freescale.com>
Subject: RE: [PATCH 1/9] pci_ids: Add device ID for IBM PCI-X bridge
Date: Thu, 8 Mar 2012 07:55:49 +0000
Message-ID: <3E027F8168735B46AC006B1D0C7BB00209A4B5@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1331024707-15891-1-git-send-email-chenhui.zhao@freescale.com>
 <08B5FFBF-FFF7-45FF-A98D-181CC0E6CEBC@kernel.crashing.org>
In-Reply-To: <08B5FFBF-FFF7-45FF-A98D-181CC0E6CEBC@kernel.crashing.org>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
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
> Sent: Tuesday, March 06, 2012 20:14 PM
> To: Zhao Chenhui-B35336
> Cc: linux-pci@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH 1/9] pci_ids: Add device ID for IBM PCI-X bridge
>=20
>=20
> On Mar 6, 2012, at 3:05 AM, Zhao Chenhui wrote:
>=20
> > Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> > ---
> > include/linux/pci_ids.h |    1 +
> > 1 files changed, 1 insertions(+), 0 deletions(-)
>=20
> Just merge this with the 2nd patch that actually uses the ID.
Why does this necessary?
I'd prefer using a separate patch for the PCI ID.
Roy
