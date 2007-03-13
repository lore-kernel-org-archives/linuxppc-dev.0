Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 1B7BCDDDF6
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 16:32:55 +1100 (EST)
Date: Mon, 12 Mar 2007 22:33:38 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Scott Wood <scottwood@freescale.com>, paulus@samba.org,
	linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 08/19] bootwrapper: Rename p and pp to anchor and
	anchorptr.
Message-ID: <20070313053338.GC27618@mag.az.mvista.com>
References: <20070312204150.GH28545@ld0162-tx32.am.freescale.net>
	<20070313021955.GK29506@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070313021955.GK29506@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 13, 2007 at 01:19:55PM +1100, David Gibson wrote:
> On Mon, Mar 12, 2007 at 02:41:50PM -0600, Scott Wood wrote:
> > This makes the meaning of "p" clearer, and increases the visual
> > difference between the two to avoid bugs such as the one fixed in
> > "Modify *pp, not *p, in ft_shuffle()".
> 
> Hrm.  This does increase the visual difference, but honestly the
> meaning of "anchor" is not notably more obvious to me than "p".

Ditto :)
