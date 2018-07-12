Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41QzgH0R60zF36L
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2018 12:00:59 +1000 (AEST)
Message-ID: <42f86d0a57a46e29d3320233ead50b4e1f60529d.camel@neuling.org>
Subject: Re: [PATCH 2/3] selftests/powerpc: Remove Power9 paste tests
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: chris@distroguy.com
Date: Thu, 12 Jul 2018 12:00:58 +1000
In-Reply-To: <20180711071017.5128-2-mpe@ellerman.id.au>
References: <20180711071017.5128-1-mpe@ellerman.id.au>
 <20180711071017.5128-2-mpe@ellerman.id.au>
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

On Wed, 2018-07-11 at 17:10 +1000, Michael Ellerman wrote:
> Paste on POWER9 only works to accelerators and not on real memory. So
> these tests just generate a SIGILL.
>=20
> So just delete them.
>=20
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Acked-by: Michael Neuling <mikey@neuling.org>
