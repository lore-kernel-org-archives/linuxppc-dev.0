Return-Path: <dgibson@ozlabs.org>
Date: Wed, 19 Sep 2007 13:16:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 08/28] bootwrapper: Use fsl_get_immr() in cuboot-pq2.c.
Message-ID: <20070919031631.GJ23646@localhost.localdomain>
References: <20070917165643.GA6545@loki.buserror.net>
	<20070917165737.GH6563@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070917165737.GH6563@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 17, 2007 at 11:57:37AM -0500, Scott Wood wrote:

Needs a commit comment

> Signed-off-by: Scott Wood <scottwood@freescale.com>


> ---
>  arch/powerpc/boot/cuboot-pq2.c |   10 ++++------
>  1 files changed, 4 insertions(+), 6 deletions(-)
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
