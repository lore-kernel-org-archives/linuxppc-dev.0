Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0A756B6F80
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2011 16:44:24 +1100 (EST)
Subject: Re: [PATCH v13 0/6] flexcan: Add support for powerpc flexcan
 (freescale p1010)
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1313551944-28603-1-git-send-email-holt@sgi.com>
Date: Tue, 18 Oct 2011 00:44:07 -0500
Message-Id: <16FBAA47-5133-43A1-80CE-C6D63B79FB5D@kernel.crashing.org>
References: <1313551944-28603-1-git-send-email-holt@sgi.com>
To: Robin Holt <holt@sgi.com>
Cc: netdev@vger.kernel.org, U Bhaskar-B22300 <B22300@freescale.com>,
 socketcan-core@lists.berlios.de, PPC list <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 16, 2011, at 10:32 PM, Robin Holt wrote:

> David,
>=20
> The following set of patches have been reviewed by the above parties =
and
> all comments have been integrated.  Although the patches stray from =
the
> drivers/net/can directory, the diversions are related to changes for
> the flexcan driver.
>=20
> The patch set is based upon your net-next-2.6 tree's commit 6c37e46.
>=20
> Could you please queue these up for the next appropriate push to =
Linus'
> tree?
>=20
> Thanks,
> Robin Holt

Robin,

Do you remember why we went with just 'fsl,p1010-flexcan' as the device =
tree compatible?  Do we feel the flex can on P1010 isn't the same as on =
MPC5xxx? or the ARM SoCs?

- k=
