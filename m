Return-Path: <afaerber@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id C048A1007D6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2011 18:51:19 +1100 (EST)
Message-ID: <4EE9A6A5.2050600@suse.de>
Date: Thu, 15 Dec 2011 08:49:57 +0100
From: =?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] offb: Add palette hack for qemu "standard vga"
 framebuffer
References: <1323907109.21839.28.camel@pasglop>
In-Reply-To: <1323907109.21839.28.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: linux-fbdev@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am 15.12.2011 00:58, schrieb Benjamin Herrenschmidt:
> We rename the mach64 hack to "simple" since that's also applicable
> to anything using VGA-style DAC IO ports (set to 8-bit DAC) and we
> use it for qemu vga.
> 
> Note that this is keyed on a device-tree "compatible" property that
> is currently only set by an upcoming version of SLOF when using the
> qemu "pseries" platform. This is on purpose as other qemu ppc platforms
> using OpenBIOS aren't properly setting the DAC to 8-bit at the time of
> the writing of this patch.
> 
> We can fix OpenBIOS later to do that and add the required property, in
> which case it will be matched by this change.

Just let me know what's needed for OpenBIOS.
Is this just for -vga std as opposed to the default cirrus?

Cheers,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imendörffer; HRB 16746 AG Nürnberg
