Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5B4D91A0BE8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2015 15:26:20 +1000 (AEST)
Message-ID: <1432272380.29160.31.camel@neuling.org>
Subject: Re: [PATCH 07/19] cxl: Re-order card init to check the VSEC earlier
From: Michael Neuling <mikey@neuling.org>
To: Ian Munsie <imunsie@au1.ibm.com>
Cc: mpe <mpe@ellerman.id.au>, benh <benh@kernel.crashing.org>, "Matthew R.
 Ochs" <mrochs@linux.vnet.ibm.com>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, brking
 <brking@linux.vnet.ibm.com>, Daniel Axtens <dja@axtens.net>
Date: Fri, 22 May 2015 15:26:20 +1000
In-Reply-To: <1432199187-sup-2028@delenn.ozlabs.ibm.com>
References: <1432034556-32400-1-git-send-email-mikey@neuling.org>
 <1432034556-32400-8-git-send-email-mikey@neuling.org>
 <1432199187-sup-2028@delenn.ozlabs.ibm.com>
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

On Thu, 2015-05-21 at 19:09 +1000, Ian Munsie wrote:
> I think this is missing the From line to indicate I wrote it ;)

Oops, yeah, although you could just change your name and that would also
fix the problem.=20

Mikey

> Otherwise...
>=20
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>
>=20
> ;-)
>=20
