Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1CE852C0090
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 12:50:02 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r6P2nwKM025181
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 21:49:59 -0500
Message-ID: <1374720597.6142.49.camel@pasglop>
Subject: Re: [PATCH] powerpc/pmac: Early debug output on screen on 64-bit macs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 25 Jul 2013 12:49:57 +1000
In-Reply-To: <1374718352.6142.48.camel@pasglop>
References: <1374718352.6142.48.camel@pasglop>
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

On Thu, 2013-07-25 at 12:12 +1000, Benjamin Herrenschmidt wrote:
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -10,7 +10,7 @@
>   *      2 of the License, or (at your option) any later version.
>   */
>  
> -#undef DEBUG
> +#define DEBUG

Ooops... sent the wrong version. Will send an updated one later,
if there are no other comments.

Cheers,
Ben.
