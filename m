Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id D8A1F679E9
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Apr 2006 10:08:46 +1100 (EST)
Date: Fri, 31 Mar 2006 17:08:28 -0600
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 2/2] Base pSeries PCIe support
Message-ID: <20060331230827.GD952@pb15.lixom.net>
References: <20060331160203.f2bf8b53.moilanen@austin.ibm.com>
	<20060331161330.3c723103.moilanen@austin.ibm.com>
	<20060331224858.GC952@pb15.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060331224858.GC952@pb15.lixom.net>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 31, 2006 at 04:48:58PM -0600, Olof Johansson wrote:

> > +	dn->intrs = prom_alloc(dn->n_intrs * sizeof(*(dn->intrs)), mem_start);
> > +	if (!dn->intrs) {
> > +		printk(KERN_EMERG "finish_msi_node: can't allocate space\n");
> > +		return;
> > +	}
> > +
> > +	if (measure_only)
> > +		return;
> 
> You probably want to return from measure_only _before_ you allocate and
> populate intrs...

Nevermind, this is correct as-is.


-Olof
