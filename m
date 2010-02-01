Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 44D1BB7D69
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Feb 2010 13:09:57 +1100 (EST)
Subject: Re: [PATCH] nodmask.h: remove macro any_online_node
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: H Hartley Sweeten <hartleys@visionengravers.com>
In-Reply-To: <201001061624.59118.hartleys@visionengravers.com>
References: <201001061624.59118.hartleys@visionengravers.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 01 Feb 2010 13:05:58 +1100
Message-ID: <1264989958.8287.13.camel@pasglop>
Mime-Version: 1.0
Cc: neilb@suse.de, Trond.Myklebust@netapp.com, bfields@fieldses.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	Ricardo.Labiaga@netapp.com, rientjes@google.com, mel@csn.ul.ie,
	devicetree-discuss@lists.ozlabs.org, akpm@linux-foundation.org,
	kamezawa.hiroyu@jp.fujitsu.com, lee.schermerhorn@hp.com,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	Linux Kernel <linux-kernel@vger.kernel.org>, miltonm@bga.com,
	dave@linux.vnet.ibm.com, chuck.lever@oracle.com,
	bhalevy@panasas.com, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-01-06 at 16:24 -0700, H Hartley Sweeten wrote:
> nodmask.h: remove macro any_online_node
> 
> The macro any_online_node is prone to producing sparse warnings
> due to the local symbol 'node'. Since all the in-tree users are really
> requesting the first online node (the mask argument is either
> NODE_MASK_ALL or node_online_map) just use the first_online_node
> macro and remove the any_online_node macro since there are no users.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> Cc: Mel Gorman <mel@csn.ul.ie>
> Cc: Lee Schermerhorn <lee.schermerhorn@hp.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Dave Hansen <dave@linux.vnet.ibm.com>
> Cc: Milton Miller <miltonm@bga.com>
> Cc: Nathan Fontenot <nfont@austin.ibm.com>
> Cc: Geoff Levand <geoffrey.levand@am.sony.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: J. Bruce Fields <bfields@fieldses.org>
> Cc: Neil Brown <neilb@suse.de>
> Cc: Trond Myklebust <Trond.Myklebust@netapp.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Benny Halevy <bhalevy@panasas.com>
> Cc: Chuck Lever <chuck.lever@oracle.com>
> Cc: Ricardo Labiaga <Ricardo.Labiaga@netapp.com>

Cheers,
Ben.
