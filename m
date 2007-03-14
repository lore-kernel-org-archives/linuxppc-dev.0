Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id EF701DDE0F
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 03:03:01 +1100 (EST)
Date: Wed, 14 Mar 2007 11:02:55 -0500
From: Scott Wood <scottwood@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 15/19] bootwrapper: Add dt_ops methods.
Message-ID: <20070314160255.GB10075@ld0162-tx32.am.freescale.net>
References: <20070312204201.GO28545@ld0162-tx32.am.freescale.net>
	<17911.31508.878043.41229@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17911.31508.878043.41229@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 14, 2007 at 03:33:24PM +1100, Paul Mackerras wrote:
> Scott Wood writes:
> 
> > +static inline void *find_node_by_prop_value_str(const void *prev,
> > +                                                const char *propname,
> > +                                                const char *propval)
> 
> That name sure is a mouthful.  

I had it as find_prop_str() before, but someone asked for a more
descriptive name.

> Since we mostly (only?) use it with propname == "device_type", why not
> make a helper with a nice, (relatively) short name like
> "find_node_by_type" for that case?

OK.

-Scott
