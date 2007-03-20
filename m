Return-Path: <dgibson@ozlabs.org>
Date: Tue, 20 Mar 2007 11:36:47 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 2/7] boot: rebuild when wrapper changes
Message-ID: <20070320003647.GA19728@localhost.localdomain>
References: <boot-00.miltonm@bga.com> <boot-02.miltonm@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <boot-02.miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 19, 2007 at 02:58:04PM -0600, Milton Miller wrote:
> 
> Since there is magic defined per platform in the wrapper script, the
> zImage targets should depend on it.
> 
> Signed-off-by: Milton Miller <miltonm@bga.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
