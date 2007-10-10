Return-Path: <dgibson@ozlabs.org>
Date: Wed, 10 Oct 2007 15:47:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: bootwrapper: relative finddevice()
Message-ID: <20071010054751.GH32426@localhost.localdomain>
References: <470AA012.9080401@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <470AA012.9080401@freescale.com>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 08, 2007 at 04:24:34PM -0500, Scott Wood wrote:
> I'd like to expose flatdevtree's ability to do relative path lookups in 
> ops, and I'd prefer to extend the existing finddevice method rather than 
> add a new finddevice_rel.  However, I'm not very familiar with real OF 
> -- how would one go about fixing its implementation?

Well, it should be possible to do package-to-path on the start node,
join the paths then finddevice on the result.  I'm not sure if there's
an easier way.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
