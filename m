Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EB09FB71A4
	for <linuxppc-dev@ozlabs.org>; Sat, 21 May 2011 00:48:25 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 02/14] powerpc: Add a defconfig for 'corenet' 32-bit
	platforms
Date: Fri, 20 May 2011 14:45:11 +0000
Message-ID: <BANLkTimzQ3PUpJQB_sF+PM9DAL+kAYgDYw@mail.gmail.com>
References: <1305871771-16334-1-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-2-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1305871771-16334-2-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 20, 2011 at 1:09 AM, Kumar Gala <galak@kernel.crashing.org> wro=
te:

> +CONFIG_MATH_EMULATION=3Dy

Don't these chips have hardware floating point?

> +CONFIG_FORCE_MAX_ZONEORDER=3D13

This may be unnecessary.  I originally set CONFIG_FORCE_MAX_ZONEORDER
to 12 because the DIU driver needs to be able to allocate a contiguous
5MB memory block.  Setting it to 13 means a max of 16MB.  Is there a
reason the default isn't good enough?

--=20
Timur Tabi
Linux kernel developer at Freescale=
