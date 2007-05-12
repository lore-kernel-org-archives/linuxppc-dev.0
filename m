Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17989.1446.330976.16221@cargo.ozlabs.ibm.com>
Date: Sat, 12 May 2007 10:09:10 +1000
From: Paul Mackerras <paulus@samba.org>
To: Simon Arlott <simon@fire.lp0.eu>
Subject: Re: [PATCH] spelling fixes: arch/powerpc/
In-Reply-To: <4644C734.3000303@simon.arlott.org.uk>
References: <4644C734.3000303@simon.arlott.org.uk>
Cc: linuxppc-dev@ozlabs.org, trivial@kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Simon Arlott writes:

> Spelling fixes in arch/powerpc/.

> -	/* Retreive CPU related informations from the flat tree
> +	/* Retreive CPU related information from the flat tree
	       ^^
You missed one. :)

> -	/* Clear the freeze bit, and reenable the interrupt.
> +	/* Clear the freeze bit, and re-enable the interrupt.

reenable -> re-enable is a bit marginal, but OK.

>  	/* Ok, now let's get cracking. You may ask me why I just didn't match
>  	 * the iic host from the iic OF node, but that way I'm still compatible
> -	 * with really really old old firmwares for which we don't have a node
> +	 * with really really old old firmware for which we don't have a node

I think "firmwares" here was meaning to imply there were more than one
instance or release of firmware which had the property described, and
your change loses that.

> -	 * differenciate them all and since that hack was there for a long
> +	 * differentiate them all and since that hack was there for a long

I haven't been too strict about the Franglais in the past, but OK. :)

Paul.
