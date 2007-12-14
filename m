Return-Path: <dgibson@ozlabs.org>
Date: Sat, 15 Dec 2007 09:03:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 1/8] powerpc: prpmc2800 - Convert dts file to v1
Message-ID: <20071214220335.GA21311@localhost.localdomain>
References: <20071211003108.GA4995@mag.az.mvista.com>
	<20071211003738.GB4995@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071211003738.GB4995@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 10, 2007 at 05:37:38PM -0700, Mark A. Greer wrote:
> From: Mark A. Greer <mgreer@mvista.com>
> 
> Convert the prpmc2800.dts file to dts-v1.  Basically, this means
> converting the numeric constants to be 'C'-like (e.g., hexadecimal
> numbers start with '0x').

[snip]
>  				interrupt-parent = <&/mv64x60/pic>;

If you're converting to dts-v1, you should also convert any path
references like this to &{/mv64x60/pic} or else use a label.  Yes,
some early dts-v1 supporting dtc versions supported these as is, but
the idea is to try to forget that they existed and always require the
{} quoting in dts-v1.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
