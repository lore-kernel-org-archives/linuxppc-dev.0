Return-Path: <dgibson@ozlabs.org>
Date: Thu, 19 Apr 2007 12:05:20 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jerry Van Baren <gvb.uboot@gmail.com>
Subject: Re: [PATCH: dtc take 2] Assemble the blob in memory before writing it
	out.
Message-ID: <20070419020520.GA4994@localhost.localdomain>
References: <20070419015951.GA9339@dellserver.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070419015951.GA9339@dellserver.lan>
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com, u-boot-users@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 18, 2007 at 09:59:51PM -0400, Jerry Van Baren wrote:
> This makes padding out the blob if the user requested extra size much
> easer.  The assembly and writing to the file is more straight forward too.
> 
> Signed-off-by: Gerald Van Baren <vanbaren@cideas.com>
> ---
> 
> Hi David, Jon,
> 
> I wasn't happy with David's suggestion on the -S handling.  I also wasn't
> all that wild about how the blob was assembled and then written to the
> file piecemeal with "ad-hoc" alignment padding.  I realized I could fix
> both by assembling the blob in memory as a "struct data" and then write
> the whole thing out in one fell swoop.
> 
> Makes it a lot simpler and cleaner to my eyes.

I like it.  (In fact my original suggestion about using
data_append_zeroes() was based on a mistaken vague notion that we
already did it this way).

Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
