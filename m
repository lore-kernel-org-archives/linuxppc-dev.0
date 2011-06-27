Return-Path: <B11780@freescale.com>
Received: from CH1EHSOBE006.bigfish.com (ch1ehsobe003.messaging.microsoft.com
	[216.32.181.183]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 90CE5B6F6B
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jun 2011 23:34:56 +1000 (EST)
Received: from mail11-ch1 (localhost.localdomain [127.0.0.1])	by
	mail11-ch1-R.bigfish.com (Postfix) with ESMTP id 40FF35A0208	for
	<linuxppc-dev@ozlabs.org>; Mon, 27 Jun 2011 13:34:52 +0000 (UTC)
Received: from CH1EHSMHS011.bigfish.com (snatpool1.int.messaging.microsoft.com
	[10.43.68.248])	by mail11-ch1.bigfish.com (Postfix) with ESMTP id
	26FE4BC004F
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jun 2011 13:34:52 +0000 (UTC)
Subject: Re: [PATCH 2/2] powerpc/86xx: improve calculation of DIU pixel clock
	on the MPC8610 HPCD
MIME-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1308845808-11392-2-git-send-email-timur@freescale.com>
Date: Mon, 27 Jun 2011 08:34:53 -0500
Message-ID: <43DC6D1C-E0DC-4CE1-91DD-BA1A059AD2D8@freescale.com>
References: <1308845808-11392-1-git-send-email-timur@freescale.com>
	<1308845808-11392-2-git-send-email-timur@freescale.com>
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


On Jun 23, 2011, at 11:16 AM, Timur Tabi wrote:

> mpc8610hpcd_set_pixel_clock() calculates the correct value of the =
PXCLK
> bits in the CLKDVDR register for a given pixel clock rate.  The code =
which
> performs this calculation is overly complicated and includes an error
> estimation routine that doesn't work most of the time anyway.  Replace =
the
> code with the simpler routine that's currently used on the P1022DS.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/platforms/86xx/mpc8610_hpcd.c |  107 =
++++++++++++---------------
> 1 files changed, 48 insertions(+), 59 deletions(-)

applied to next

- K=
