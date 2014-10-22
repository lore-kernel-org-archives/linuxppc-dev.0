Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AB9961A0188
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Oct 2014 16:31:11 +1100 (AEDT)
Message-ID: <1413955870.9754.3.camel@concordia>
Subject: Re: [PATCH] powernv: Use _GLOBAL_TOC for opal wrappers
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jeremy Kerr <jk@ozlabs.org>
Date: Wed, 22 Oct 2014 16:31:10 +1100
In-Reply-To: <1413948772.62479.492398078454.1.gpush@pablo>
References: <1413948772.62479.492398078454.1.gpush@pablo>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-10-22 at 11:32 +0800, Jeremy Kerr wrote:
> Currently, we can't call opal wrappers from modules when using the LE
> ABIv2, which requires a TOC init.

What happens if we try? Build failure or run time bug?

> This change uses the _GLOBAL_TOC() macro (rather than _GLOBAL) for the
> opal wrappers, so that we can do non-local calls to them.

Are we doing that now, or we would like to?

cheers
