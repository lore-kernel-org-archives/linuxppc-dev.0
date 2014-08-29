Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 54B2D1A0018
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Aug 2014 11:55:57 +1000 (EST)
Message-ID: <1409277356.9191.4.camel@concordia>
Subject: Re: [PATCH] powerpc: Check flat device tree version at boot
From: Michael Ellerman <mpe@ellerman.id.au>
To: Rob Herring <robherring2@gmail.com>
Date: Fri, 29 Aug 2014 11:55:56 +1000
In-Reply-To: <CAL_Jsq+DSC4DW-ULuFfUjowsCOXbRnXvYSQcLY4inuBuztuh7A@mail.gmail.com>
References: <1409215247-10195-1-git-send-email-mpe@ellerman.id.au>
 <CAL_Jsq+DSC4DW-ULuFfUjowsCOXbRnXvYSQcLY4inuBuztuh7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Grant Likely <grant.likely@linaro.org>, linuxppc-dev@ozlabs.org,
 Rob Herring <robh+dt@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-08-28 at 09:27 -0500, Rob Herring wrote:
> On Thu, Aug 28, 2014 at 3:40 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> > In commit e6a6928c3ea1 "of/fdt: Convert FDT functions to use libfdt",
> > the kernel stopped supporting old flat device tree formats. The minimum
> > supported version is now 0x10.
> 
> Ugg. Is that something which needs to be supported? Supporting it at
> this point would mean adding support to libfdt.

Well it would have been nice to keep supporting v2, dropping it broke
kexec-tools for example. But it's done now, so we'll just deal with the
fallout.

If you can CC linuxppc-dev in future on patches that fundamentally change the
device tree parsing that would be appreciated :)

cheers
