Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE003.bigfish.com (mail-am1.bigfish.com
 [213.199.180.138])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id ACBE4B70BC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2011 04:23:05 +1100 (EST)
Date: Thu, 10 Nov 2011 10:46:11 -0600
From: Scott Wood <scottwood@freescale.com>
To: Kyle Moffett <Kyle.D.Moffett@boeing.com>
Subject: Re: [RFC PATCH 14/17] powerpc/e500: Don't make kgdb use
 e500v1/e500v2 registers on e500mc
Message-ID: <20111110164611.GB11983@schlenkerla.am.freescale.net>
References: <4E42AB6F.1050900@freescale.com>
 <1320883635-17194-15-git-send-email-Kyle.D.Moffett@boeing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1320883635-17194-15-git-send-email-Kyle.D.Moffett@boeing.com>
Cc: Baruch Siach <baruch@tkos.co.il>, Timur Tabi <B04825@freescale.com>,
 linux-kernel@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

BOn Wed, Nov 09, 2011 at 07:07:12PM -0500, Kyle Moffett wrote:
> The only systems which need the sparse PowerPC register map are the
> e500v1/e500v2.

Is this due to SPE?

> +/*
> + * On FreeScale e500v1 or e500v2 processors we need to skip some register
> + * sections, so just add up a list of what we need to store.
> + *
> + * On all other 32-bit PowerPC we can just pick the last needed register.
> + */

The "s" in "Freescale" is not capitalized, BTW.

-Scott
