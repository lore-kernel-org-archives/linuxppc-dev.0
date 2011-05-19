Return-Path: <B11780@freescale.com>
Received: from CH1EHSOBE001.bigfish.com (ch1ehsobe003.messaging.microsoft.com
	[216.32.181.183]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8A616B6F7E
	for <linuxppc-dev@ozlabs.org>; Thu, 19 May 2011 15:57:35 +1000 (EST)
Received: from mail170-ch1 (localhost.localdomain [127.0.0.1])	by
	mail170-ch1-R.bigfish.com (Postfix) with ESMTP id E982447058A	for
	<linuxppc-dev@ozlabs.org>; Thu, 19 May 2011 05:42:23 +0000 (UTC)
Received: from CH1EHSMHS031.bigfish.com (snatpool1.int.messaging.microsoft.com
	[10.43.68.245])	by mail170-ch1.bigfish.com (Postfix) with ESMTP id
	C707A21805C	for <linuxppc-dev@ozlabs.org>;
	Thu, 19 May 2011 05:42:23 +0000 (UTC)
Subject: Re: [PATCH] powerpc/86xx: don't pretend that we support 8-bit pixels
	on the MPC8610 HPCD
MIME-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1304969380-24897-1-git-send-email-timur@freescale.com>
Date: Thu, 19 May 2011 00:42:20 -0500
Message-ID: <CFC69082-77DB-4459-8038-B356E28304E4@freescale.com>
References: <1304969380-24897-1-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 9, 2011, at 2:29 PM, Timur Tabi wrote:

> If the video mode is set to 16-, 24-, or 32-bit pixels, then the pixel =
data
> contains actual levels of red, blue, and green.  However, if the video =
mode is
> set to 8-bit pixels, then the 8-bit value represents an index into =
color table.
> This is called "palette mode" on the Freescale DIU video controller.
>=20
> The DIU driver does not currently support palette mode, but the =
MPC8610 HPCD
> board file returned a non-zero (although incorrect) pixel format value =
for
> 8-bit mode.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/platforms/86xx/mpc8610_hpcd.c |   97 =
++++++++++++++++++----------
> 1 files changed, 64 insertions(+), 33 deletions(-)

applied to next

- k=
