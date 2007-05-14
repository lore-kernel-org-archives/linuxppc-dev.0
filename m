Return-Path: <dgibson@ozlabs.org>
Date: Mon, 14 May 2007 10:18:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Becky Bruce <becky.bruce@freescale.com>
Subject: Re: [PATCH] Remove ft_ordered from flatdevtree.c
Message-ID: <20070514001844.GB6517@localhost.localdomain>
References: <11789057794165-git-send-email-becky.bruce@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11789057794165-git-send-email-becky.bruce@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 11, 2007 at 12:49:39PM -0500, Becky Bruce wrote:
> AFAICT, nobody is using this function, and it causes a build warning
> to be generated.  This patch cleans that up by removing the function
> and the commented-out code that calls it.
> 
> Signed-off-by: Becky Bruce <becky.bruce@freescale.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
