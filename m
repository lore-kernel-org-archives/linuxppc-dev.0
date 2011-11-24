Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EE4A61007D7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 18:46:56 +1100 (EST)
Subject: Re: Fix for fsl_upm
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4EA9683D.8030100@dev.rtsoft.ru>
Date: Thu, 24 Nov 2011 01:46:32 -0600
Message-Id: <0DAA4F0B-0C32-4CF8-9E3A-EFB8B898026E@kernel.crashing.org>
References: <4EA9683D.8030100@dev.rtsoft.ru>
To: Rusev <arusev@dev.rtsoft.ru>
Cc: Shaohui.Xie@freescale.com, linux-kernel@vger.kernel.org,
 Shengzhou.Liu@freescale.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 27, 2011, at 9:18 AM, Rusev wrote:

> patch is vs. 2.6.39, yet it applied to 3.1
>=20
>=20
>=20
> Fix of UPM driver for Freescale PowerPC processors
>=20
> If Freescale LBC driver fails to initialise itself from device tree,
> then internal structure is freed only but not NULL-fied.
> As result functions fsl_lbc_find() after checking the structure is not =
NULL are
> trying to access device registers.
>=20
> Signed-off-by: Alexandre Rusev <arusev@dev.rtsoft.ru>=20

applied to next

- k=
