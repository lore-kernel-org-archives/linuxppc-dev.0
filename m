Return-Path: <linas@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B4BC267B6C
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 09:29:57 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7INTig4031299
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 19:29:44 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7INThCo374212
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 17:29:43 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7INThVa000691
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 17:29:43 -0600
Date: Fri, 18 Aug 2006 18:29:42 -0500
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/4]: powerpc/cell spidernet low watermark patch.
Message-ID: <20060818232942.GO26889@austin.ibm.com>
References: <20060818192356.GD26889@austin.ibm.com>
	<20060818.142513.29571851.davem@davemloft.net>
	<20060818224618.GN26889@austin.ibm.com>
	<20060818.155116.112621100.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060818.155116.112621100.davem@davemloft.net>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: arnd@arndb.de, jklewis@us.ibm.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, Jens.Osterkamp@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 18, 2006 at 03:51:16PM -0700, David Miller wrote:
> I see you moving TX reclaim into tasklets and stuff.  I've vehemently
> against that because you wouldn't need it in order to move TX
> processing into software interrupts if you did it all in NAPI
> ->poll().

I don't understand what you are saying. If I call the transmit 
queue cleanup code from the poll() routine, nothing hapens, 
because the kernel does not call the poll() routine often 
enough. I've stated this several times.  

--linas
