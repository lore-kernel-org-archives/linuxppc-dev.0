Return-Path: <timur.tabi@gmail.com>
Received: from mail-fx0-f221.google.com (mail-fx0-f221.google.com
	[209.85.220.221]) by ozlabs.org (Postfix) with ESMTP id 781D0B7CEF
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 11:22:30 +1100 (EST)
Received: by fxm21 with SMTP id 21so10570fxm.22
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Mar 2010 17:22:28 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <20100325.175343.706994262324563953.imp@bsdimp.com>
References: <4BAA4C8A.70104@freescale.com>
	<65327.84.105.60.153.1269481760.squirrel@gate.crashing.org>
	<ed82fe3e1003250742t5affee7dudca651ab3352bc16@mail.gmail.com>
	<20100325.175343.706994262324563953.imp@bsdimp.com>
From: Timur Tabi <timur@freescale.com>
Date: Thu, 25 Mar 2010 19:22:08 -0500
Message-ID: <ed82fe3e1003251722o784f6b96paf140e76cfdaf93@mail.gmail.com>
Subject: Re: [PATCH] powerpc/fsl: add device tree binding for QE firmware
To: "M. Warner Losh" <imp@bsdimp.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 25, 2010 at 6:53 PM, M. Warner Losh <imp@bsdimp.com> wrote:

> Most !linux systems are not GPL'd. =A0They are BSDL, primarily, or some
> private license between seller and buyer. =A0In any event, other OSes
> likely won't have the GPL issue.

You're probably right.

> But I'm confused. =A0If you can't distribute the binary firmware, why
> can you distribute the hex dump of the firmware?

We can distribute the binary firmware.  We just can't embed it in the
Linux kernel, since it's not GPL.  So it needs to be delivered to the
kernel at boot time via a non-GPL mechanism.  The device tree is one
option.  An initrd is another.  The problem Freescale has is that
modifying our BSP to use an initrd is not a trivial task, and it's a
lot more complicated than using the device tree.  For example, there's
the possibility that U-Boot and Linux will use different microcode
binaries, and it also means that the initrd becomes SOC-specific.

--=20
Timur Tabi
Linux kernel developer at Freescale
