Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6996D1A02EA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 01:48:24 +1100 (AEDT)
Message-ID: <1453819695.27129.26.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Alessio Igor Bogani <alessio.bogani@elettra.eu>, Kumar Gala
 <galak@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Tue, 26 Jan 2016 08:48:15 -0600
In-Reply-To: <1453811127-28591-1-git-send-email-alessio.bogani@elettra.eu>
References: <1453811127-28591-1-git-send-email-alessio.bogani@elettra.eu>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: powerpc/dts: Move mvme2500.dts back in the right place
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-01-26 at 13:25 +0100, Alessio Igor Bogani wrote:
> Commit dc37374b9c83 ("powerpc/fsl: Move Freescale device tree files into
> fsl folder") move also mvme2500.dts which isn't a device tree for a
> Freescale board but for an Artesyn one. So move mvme2500.dts back in the
> right place.

It's not about who makes the board.  In theory it's for all boards with a
Freescale SoC.  The initial set that was moved was those which use dtsi files
from the fsl directory.  The motivation was that some of the dtsi files are
now requiring the preprocessor, and preprocessor includes don't mix well with
dts includes that change the current directory.

-Scott
