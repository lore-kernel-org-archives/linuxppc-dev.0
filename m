Return-Path: <dgibson@ozlabs.org>
Date: Tue, 13 Mar 2007 13:19:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 08/19] bootwrapper: Rename p and pp to anchor and
	anchorptr.
Message-ID: <20070313021955.GK29506@localhost.localdomain>
References: <20070312204150.GH28545@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070312204150.GH28545@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 12, 2007 at 02:41:50PM -0600, Scott Wood wrote:
> This makes the meaning of "p" clearer, and increases the visual
> difference between the two to avoid bugs such as the one fixed in
> "Modify *pp, not *p, in ft_shuffle()".

Hrm.  This does increase the visual difference, but honestly the
meaning of "anchor" is not notably more obvious to me than "p".

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
