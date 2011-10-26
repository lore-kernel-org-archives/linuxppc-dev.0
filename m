Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DC5691007D9
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Oct 2011 14:35:08 +1100 (EST)
Subject: Re: [PATCH 06/11] powerpc/85xx: Add ethernet magic packet property to
 P1020 device tree
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4EA735E8.5010206@freescale.com>
Date: Tue, 25 Oct 2011 22:35:08 -0500
Message-Id: <6549A2B9-A9FD-42BC-A3B0-B920167739F5@kernel.crashing.org>
References: <1319318452-27036-1-git-send-email-galak@kernel.crashing.org>
 <1319318452-27036-2-git-send-email-galak@kernel.crashing.org>
 <1319318452-27036-3-git-send-email-galak@kernel.crashing.org>
 <1319318452-27036-4-git-send-email-galak@kernel.crashing.org>
 <1319318452-27036-5-git-send-email-galak@kernel.crashing.org>
 <1319318452-27036-6-git-send-email-galak@kernel.crashing.org>
 <4EA735E8.5010206@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 25, 2011, at 5:19 PM, Scott Wood wrote:

> On 10/22/2011 04:20 PM, Kumar Gala wrote:
>> All eTSEC2 controllers support waking on magic packet so fixup device
>> tree to report that.
>=20
> If they *all* support it, we can make the driver rely on the =
compatible
> instead.
>=20
> -Scott

I think this might have originated on eTSEC v1, in which all controllers =
don't support it.

I'm not against removing it & just using compatible but don't know =
enough about these nodes to comment.

- k=
