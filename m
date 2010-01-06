Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail9.fujitsu.co.jp (fgwmail9.fujitsu.co.jp [192.51.44.39])
	by ozlabs.org (Postfix) with ESMTP id 84571B6F04
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jan 2010 11:43:43 +1100 (EST)
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
	by fgwmail9.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o06NtpXU001187 for <linuxppc-dev@ozlabs.org> (envelope-from
	kamezawa.hiroyu@jp.fujitsu.com); Thu, 7 Jan 2010 08:55:51 +0900
Received: from m5.gw.fujitsu.co.jp ([10.0.50.75])
	by fgwmail5.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o06NtoQh014852 for <linuxppc-dev@ozlabs.org> (envelope-from
	kamezawa.hiroyu@jp.fujitsu.com); Thu, 7 Jan 2010 08:55:50 +0900
Received: from smail (m5 [127.0.0.1])
	by outgoing.m5.gw.fujitsu.co.jp (Postfix) with ESMTP id DF76545DE51
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jan 2010 08:55:49 +0900 (JST)
Received: from s5.gw.fujitsu.co.jp (s5.gw.fujitsu.co.jp [10.0.50.95])
	by m5.gw.fujitsu.co.jp (Postfix) with ESMTP id B85C845DE4F
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jan 2010 08:55:49 +0900 (JST)
Received: from s5.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s5.gw.fujitsu.co.jp (Postfix) with ESMTP id A5D061DB803F
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jan 2010 08:55:49 +0900 (JST)
Received: from m107.s.css.fujitsu.com (m107.s.css.fujitsu.com [10.249.87.107])
	by s5.gw.fujitsu.co.jp (Postfix) with ESMTP id 5954E1DB805A
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jan 2010 08:55:46 +0900 (JST)
Date: Thu, 7 Jan 2010 08:51:46 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: Re: [PATCH] nodmask.h: remove macro any_online_node
Message-Id: <20100107085146.59cc9888.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <201001061624.59118.hartleys@visionengravers.com>
References: <201001061624.59118.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: neilb@suse.de, Trond.Myklebust@netapp.com, bfields@fieldses.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, rientjes@google.com,
	mel@csn.ul.ie, devicetree-discuss@lists.ozlabs.org,
	akpm@linux-foundation.org, Ricardo.Labiaga@netapp.com,
	lee.schermerhorn@hp.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
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

On Wed, 6 Jan 2010 16:24:58 -0700
H Hartley Sweeten <hartleys@visionengravers.com> wrote:

> nodmask.h: remove macro any_online_node
> 
> The macro any_online_node is prone to producing sparse warnings
> due to the local symbol 'node'. Since all the in-tree users are really
> requesting the first online node (the mask argument is either
> NODE_MASK_ALL or node_online_map) just use the first_online_node
> macro and remove the any_online_node macro since there are no users.
> 

Reviewed-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Thank you.
BTW, it's better to add diffstat to this kind of changes.

Regards,
-Kame

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
> 
> ---
> 
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index b037d95..64c0022 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -451,7 +451,7 @@ static int __cpuinit numa_setup_cpu(unsigned long lcpu)
>  	nid = of_node_to_nid_single(cpu);
>  
>  	if (nid < 0 || !node_online(nid))
> -		nid = any_online_node(NODE_MASK_ALL);
> +		nid = first_online_node;
>  out:
>  	map_cpu_to_node(lcpu, nid);
>  
> @@ -1114,7 +1114,7 @@ int hot_add_scn_to_nid(unsigned long scn_addr)
>  	int nid, found = 0;
>  
>  	if (!numa_enabled || (min_common_depth < 0))
> -		return any_online_node(NODE_MASK_ALL);
> +		return first_online_node;
>  
>  	memory = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
>  	if (memory) {
> @@ -1125,7 +1125,7 @@ int hot_add_scn_to_nid(unsigned long scn_addr)
>  	}
>  
>  	if (nid < 0 || !node_online(nid))
> -		nid = any_online_node(NODE_MASK_ALL);
> +		nid = first_online_node;
>  
>  	if (NODE_DATA(nid)->node_spanned_pages)
>  		return nid;
> diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
> index 454997c..c4fa64b 100644
> --- a/include/linux/nodemask.h
> +++ b/include/linux/nodemask.h
> @@ -69,8 +69,6 @@
>   * int node_online(node)		Is some node online?
>   * int node_possible(node)		Is some node possible?
>   *
> - * int any_online_node(mask)		First online node in mask
> - *
>   * node_set_online(node)		set bit 'node' in node_online_map
>   * node_set_offline(node)		clear bit 'node' in node_online_map
>   *
> @@ -467,15 +465,6 @@ static inline int num_node_state(enum node_states state)
>  #define node_online_map 	node_states[N_ONLINE]
>  #define node_possible_map 	node_states[N_POSSIBLE]
>  
> -#define any_online_node(mask)			\
> -({						\
> -	int node;				\
> -	for_each_node_mask(node, (mask))	\
> -		if (node_online(node))		\
> -			break;			\
> -	node;					\
> -})
> -
>  #define num_online_nodes()	num_node_state(N_ONLINE)
>  #define num_possible_nodes()	num_node_state(N_POSSIBLE)
>  #define node_online(node)	node_state((node), N_ONLINE)
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 538ca43..832c1fe 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -133,7 +133,7 @@ svc_pool_map_choose_mode(void)
>  		return SVC_POOL_PERNODE;
>  	}
>  
> -	node = any_online_node(node_online_map);
> +	node = first_online_node;
>  	if (nr_cpus_node(node) > 2) {
>  		/*
>  		 * Non-trivial SMP, or CONFIG_NUMA on
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
