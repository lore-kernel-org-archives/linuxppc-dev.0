Return-Path: <robert.karl.berger@gmail.com>
Received: from mail-ee0-f42.google.com (mail-ee0-f42.google.com [74.125.83.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 93C792C008D
 for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2012 02:39:25 +1100 (EST)
Received: by mail-ee0-f42.google.com with SMTP id l10so693898eei.15
 for <linuxppc-dev@ozlabs.org>; Sun, 21 Oct 2012 08:39:21 -0700 (PDT)
Message-ID: <50841724.4030301@gmail.com>
Date: Sun, 21 Oct 2012 18:39:16 +0300
From: Robert Berger <robert.karl.berger@gmail.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: ELDK 4.2/kilauea/3.5+ kernel broken
References: <507EF5AD.5070203__24977.4320669987$1350497770$gmane$org@gmail.com>
 <50802F4C.3000309__36526.1883860969$1350578085$gmane$org@gmail.com>
 <50804020.30505@gmail.com>
 <1350587006.2476.12.camel__24873.815305955$1350587085$gmane$org@pasglop>
In-Reply-To: <1350587006.2476.12.camel__24873.815305955$1350587085$gmane$org@pasglop>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On 10/18/2012 10:03 PM, Benjamin Herrenschmidt wrote:
>
> Which looks correct. So this might be something specific to ELDK ?

I just tried with the ELDK 5.2.1 and have exactly the same behavior as
with ELDK 4.2, so I guess there is something not correct in
arch/powerpc/sysdev/ppc4xx_msi.c.

Just to exclude the case that I'm doing something stupid which only
affects kernel versions 3.5+ and not 3.4 can someone else give it a try
with a kilauea board or something similar?

Regards,

Robert

>
> Cheers,
> Ben.
>
