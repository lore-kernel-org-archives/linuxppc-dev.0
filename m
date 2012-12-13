Return-Path: <akinobu.mita@gmail.com>
Received: from mail-oa0-f51.google.com (mail-oa0-f51.google.com
 [209.85.219.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 738292C008E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2012 22:06:01 +1100 (EST)
Received: by mail-oa0-f51.google.com with SMTP id n12so1901499oag.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2012 03:05:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1355353492.19932.59.camel@pasglop>
References: <1355353492.19932.59.camel@pasglop>
Date: Thu, 13 Dec 2012 20:05:58 +0900
Message-ID: <CAC5umyhg4qvM5GtdjOJrYacGt8LHO=VgaeCXeWB2CvnDHyJw3A@mail.gmail.com>
Subject: Re: [PATCH] powerpc+of: Rename and fix OF reconfig notifier error
 inject module
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2012/12/13 Benjamin Herrenschmidt <benh@kernel.crashing.org>:
> This module used to inject errors in the pSeries specific dynamic
> reconfiguration notifiers. Those are gone however, replaced by
> generic notifiers for changes to the device-tree. So let's update
> the module to deal with these instead and rename it along the way.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Looks good.

Acked-by: Akinobu Mita <akinobu.mita@gmail.com>
