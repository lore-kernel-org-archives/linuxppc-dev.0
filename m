Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9BDD21A0E09
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2015 11:22:48 +1000 (AEST)
Message-ID: <1432603368.18833.0.camel@neuling.org>
Subject: Re: [PATCH 12/19] cxl: Export some symbols
From: Michael Neuling <mikey@neuling.org>
To: Ian Munsie <imunsie@au1.ibm.com>
Cc: mpe <mpe@ellerman.id.au>, benh <benh@kernel.crashing.org>, "Matthew R.
 Ochs" <mrochs@linux.vnet.ibm.com>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, brking
 <brking@linux.vnet.ibm.com>, Daniel Axtens <dja@axtens.net>
Date: Tue, 26 May 2015 11:22:48 +1000
In-Reply-To: <1432199656-sup-1113@delenn.ozlabs.ibm.com>
References: <1432034556-32400-1-git-send-email-mikey@neuling.org>
 <1432034556-32400-13-git-send-email-mikey@neuling.org>
 <1432199656-sup-1113@delenn.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-05-21 at 19:16 +1000, Ian Munsie wrote:
> > +void assign_psn_space(struct cxl_context *ctx);
>=20
> Should we consider renaming this to cxl_assign_psn_space to namespace it
> now that it's potentially callable from elsewhere in the kernel?
>=20
> > +int afu_check_and_enable(struct cxl_afu *afu);
>=20
> Likewise?

Yep, I just resent with cxl_ added.

Mikey

> Acked-by: Ian Munsie <imunsie@au1.ibm.com>
>=20
> -Ian
>=20
