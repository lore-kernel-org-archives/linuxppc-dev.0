Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CF6CE1007D3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2012 12:22:01 +1100 (EST)
Subject: Re: 5020 SATA fix
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1329438578.2892.34.camel@pasglop>
Date: Thu, 16 Feb 2012 19:21:46 -0600
Message-Id: <73CC1DE0-8D18-4810-97B6-30F0EB6A35F1@kernel.crashing.org>
References: <1329438578.2892.34.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Xulei <B33228@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 16, 2012, at 6:29 PM, Benjamin Herrenschmidt wrote:

> Hi Lei !
>=20
> In your SDK kernel I see this commit:
>=20
> 92c0ce1e599e788ffc0908739db9bd5e0dbdad69
> sata_fsl: Add the workaround for SATA-A005 erratum on =
P2040/P3041/P5020
>=20
> Without this commit, SATA doesn't work on the p5020ds board that FSL
> just sent me. I see this was committed in June last year, any reason =
why
> this is not upstream yet ?
>=20
> Any objection to me just sending it upstream ?
>=20
> Cheers,
> Ben.
>=20

In general we've avoided sending erratum fixes for non-production =
silicon upstream.

- k
