Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8C3EB1A00E5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 00:05:11 +1100 (AEDT)
Message-ID: <1452776705.13006.1.camel@ellerman.id.au>
Subject: Re: Pull request: scottwood/linux.git next
From: Michael Ellerman <mpe@ellerman.id.au>
To: Scott Wood <oss@buserror.net>, benh@kernel.crashing.org
Cc: linuxppc-dev@lists.ozlabs.org, galak@kernel.crashing.org
Date: Fri, 15 Jan 2016 00:05:05 +1100
In-Reply-To: <20160104213855.GA19111@home.buserror.net>
References: <20160104213855.GA19111@home.buserror.net>
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

On Mon, 2016-01-04 at 15:38 -0600, Scott Wood wrote:

> Highlights include moving QE code out of arch/powerpc (to be shared with
> arm), device tree updates, and minor fixes.
> 
> Sorry for sending this in so late and not getting to everything in my
> queue -- in addition to the holidays I've been slowed down by email
> troubles and a broken arm.

No worries, I'm a bit behind this cycle owing to the break over Christmas.

Hope the arm is healing! I minced one of my fingers last year, I know how
annoying it is to try and type with one hand :)

I've merged this and pushed for tomorrow's linux-next.

cheers
