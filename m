Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40qDnX4ppKzF10l
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 20:01:20 +1000 (AEST)
In-Reply-To: <20170803125934.14960-1-peda@axentia.se>
To: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Peter Rosin <peda@axentia.se>
Subject: Re: powerpc/fsl/dts: fix the i2c-mux compatible for t104xqds
Message-Id: <40qDnX3tdWz9s33@ozlabs.org>
Date: Mon, 21 May 2018 20:01:20 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-08-03 at 12:59:34 UTC, Peter Rosin wrote:
> The sanctioned compatible is "nxp,pca9547".
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e4f2419fac381c5a7659834169dbe7

cheers
