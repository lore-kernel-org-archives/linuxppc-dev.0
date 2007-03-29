Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 24EECDDFB7
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Mar 2007 05:47:12 +1000 (EST)
Date: Thu, 29 Mar 2007 14:43:37 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Chuck Meade <chuckmeade@mindspring.com>
Subject: Re: [PATCH] Fix QUICC Engine SDMA setup errors
In-Reply-To: <46092E32.2060501@mindspring.com>
Message-ID: <Pine.LNX.4.64.0703291443290.23408@localhost.localdomain>
References: <46092E32.2060501@mindspring.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 27 Mar 2007, Chuck Meade wrote:

> Correct the alignment of the internal buffer used by the QUICC Engine
> SDMA controller to 4Kbytes.  Correct the shift direction in the logic
> that sets up the SDMR register for the QUICC Engine SDMA controller.
>
> Signed-off-by: Chuck Meade <chuckmeade@mindspring.com>
> ---
> In addition to fixing the bugs, this version of this patch addresses
> Segher's concerns about fixing the line break placement.  It also
> addresses Leo's concerns about using the more accurate term
> "QUICC Engine" rather than "MPC83xx" in the subject and header.
>
>  arch/powerpc/sysdev/qe_lib/qe.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

applied.

- k
