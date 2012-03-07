Return-Path: <B35336@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6B7DBB6EF1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2012 19:41:11 +1100 (EST)
From: Zhao Chenhui-B35336 <B35336@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH 1/9] pci_ids: Add device ID for IBM PCI-X bridge
Date: Wed, 7 Mar 2012 08:40:58 +0000
Message-ID: <7AA2FF042C086D469F577FA6723434DA015E98@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1331024707-15891-1-git-send-email-chenhui.zhao@freescale.com>
 <08B5FFBF-FFF7-45FF-A98D-181CC0E6CEBC@kernel.crashing.org>
In-Reply-To: <08B5FFBF-FFF7-45FF-A98D-181CC0E6CEBC@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
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

> On Mar 6, 2012, at 3:05 AM, Zhao Chenhui wrote:
>=20
> > Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> > ---
> > include/linux/pci_ids.h |    1 +
> > 1 files changed, 1 insertions(+), 0 deletions(-)
>=20
> Just merge this with the 2nd patch that actually uses the ID.
>=20
> - k

Ok. I put it in the file mpc85xx_cds.c.

-Chenhui
