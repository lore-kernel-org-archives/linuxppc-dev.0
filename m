Return-Path: <herbert@gondor.apana.org.au>
Received: from arnor.apana.org.au (arnor.apana.org.au [203.14.152.115])
	by ozlabs.org (Postfix) with ESMTP id 83C7167A86
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Jan 2005 09:52:54 +1100 (EST)
From: Herbert Xu <herbert@gondor.apana.org.au>
To: md@Linux.IT (Marco d'Itri)
In-Reply-To: <20050128140836.GA10777@wonderland.linux.it>
Message-Id: <E1CueYJ-0000nX-00@gondolin.me.apana.org.au>
Date: Sat, 29 Jan 2005 09:25:20 +1100
Cc: linuxppc-dev@ozlabs.org, netdev@oss.sgi.com
Subject: Re: networking-related oopses on 2.6.9
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Marco d'Itri <md@linux.it> wrote:
> 
> I have been able to capture the latest two oopses from the serial
> console, is this a known problem?
> 
> KERNEL: assertion (!skb_queue_empty(&sk->sk_write_queue)) failed at net/ipv4/tc

Yes these are known problems which should be fixed in 2.6.10.  However,
there is at least one other similar issue in 2.6.10 so you'll either
want to stay with 2.6.6 or go up to the latest bk snapshot.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
