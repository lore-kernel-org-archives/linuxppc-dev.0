Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40D0b43hMXzF1rw
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Apr 2018 01:04:00 +1100 (AEDT)
In-Reply-To: <20180317150617.26913-1-j.neuschaefer@gmx.net>
To: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 Rob Herring <robh+dt@kernel.org>, Paul Mackerras <paulus@samba.org>
Subject: Re: powerpc: wii.dts: Add drive slot LED
Message-Id: <40D0b40XzBz9s1S@ozlabs.org>
Date: Sun,  1 Apr 2018 01:03:59 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2018-03-17 at 15:06:17 UTC, =?utf-8?q?Jonathan_Neusch=C3=A4fer?= wrote:
> The Wii has a blue LED in the disk drive slot, which is controlled via a
> GPIO line. Add this LED to wii.dts, and mark it as a panic-indicator.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/041413b88d6e9c66582d0a38d0e82f

cheers
