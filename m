Return-Path: <rientjes@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [216.239.44.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A717CB7BF7
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jan 2010 11:04:29 +1100 (EST)
Received: from kpbe17.cbf.corp.google.com (kpbe17.cbf.corp.google.com
	[172.25.105.81]) by smtp-out.google.com with ESMTP id o06NrBVg021357
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Jan 2010 15:53:21 -0800
Received: from pzk41 (pzk41.prod.google.com [10.243.19.169])
	by kpbe17.cbf.corp.google.com with ESMTP id o06NpTFS019180
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Jan 2010 15:52:46 -0800
Received: by pzk41 with SMTP id 41so6376573pzk.0
	for <linuxppc-dev@ozlabs.org>; Wed, 06 Jan 2010 15:52:41 -0800 (PST)
Date: Wed, 6 Jan 2010 15:52:37 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: Re: [PATCH] nodmask.h: remove macro any_online_node
In-Reply-To: <201001061624.59118.hartleys@visionengravers.com>
Message-ID: <alpine.DEB.2.00.1001061552220.19882@chino.kir.corp.google.com>
References: <201001061624.59118.hartleys@visionengravers.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: neilb@suse.de, Trond.Myklebust@netapp.com, bfields@fieldses.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	Ricardo.Labiaga@netapp.com, mel@csn.ul.ie,
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

On Wed, 6 Jan 2010, H Hartley Sweeten wrote:

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
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
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

Acked-by: David Rientjes <rientjes@google.com>
