Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 73CF92C00C4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Mar 2013 03:17:01 +1100 (EST)
Subject: Re: [PATCH] powerpc/qe: remove useless Kconfig default
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1363124951.3137.156.camel@x61.thuisdomein>
Date: Fri, 15 Mar 2013 11:16:38 -0500
Message-Id: <61AABF0B-0F3F-4E85-98F8-4445E469EE86@kernel.crashing.org>
References: <1363124951.3137.156.camel@x61.thuisdomein>
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 12, 2013, at 4:49 PM, Paul Bolle wrote:

> The Kconfig entry for QE_USB contains
> 	default y if USB_GADGET_FSL_QE
>=20
> But USB_GADGET_FSL_QE got removed in commit
> 193ab2a6070039e7ee2b9b9bebea754a7c52fd1b ("usb: gadget: allow multiple
> gadgets to be built"). This default will therefor never be set and can
> be removed.
>=20
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> 0) Tested with "make ARCH=3Dpowerpc menuconfig" and "make ARCH=3Dpowerpc=

> oldconfig" (before and after the patch). Enough to see this patch =
didn't
> obviously break stuff.
>=20
> 1) I don't really understand commit
> 193ab2a6070039e7ee2b9b9bebea754a7c52fd1b. Was its point that we =
replace
> USB_GADGET_FSL_QE with USB_FSL_QE? I couldn't tell and chose not to
> actually change any behavior.
>=20
> arch/powerpc/sysdev/qe_lib/Kconfig | 1 -
> 1 file changed, 1 deletion(-)
>=20

You're correct that this isn't quite right, I've posted a proper patch =
that should fix this correctly.

thanks for pointing it out.

- k=
