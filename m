Return-Path: <ossthema@de.ibm.com>
Received: from mtagate4.uk.ibm.com (mtagate4.uk.ibm.com [195.212.29.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CF4DDDDDD5
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 23:28:17 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate4.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l6IDSD7M017684
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 13:28:13 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.4) with
	ESMTP id l6IDSCrP2179116
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 14:28:12 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l6IDS5B7024896
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 14:28:05 +0100
From: Jan-Bernd Themann <ossthema@de.ibm.com>
To: David Miller <davem@davemloft.net>
Subject: Re: [RFC 0/3] lro: Generic Large Receive Offload for TCP traffic
	(IPv6)
Date: Wed, 18 Jul 2007 15:00:59 +0200
References: <200707111621.24852.ossthema@de.ibm.com>
	<20070715091253.GA15790@infradead.org>
	<20070715.024015.126137834.davem@davemloft.net>
In-Reply-To: <20070715.024015.126137834.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707181501.00163.ossthema@de.ibm.com>
Cc: tklein@de.ibm.com, themann@de.ibm.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@infradead.org,
	linuxppc-dev@ozlabs.org, raisch@de.ibm.com, meder@de.ibm.com,
	stefan.roscher@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I suggest we keep the interface open for IPv6 support by adding 
an additional parameter but first just get IPv4 support only 
into the kernel. IPv6 support can then incrementially be added.
Would that be ok?



On Sunday 15 July 2007 11:40, David Miller wrote:
> From: Christoph Hellwig <hch@infradead.org>
> Date: Sun, 15 Jul 2007 10:12:53 +0100
> 
> > I'm not sure that's a good idea.  If current chips can't handle ipv6
> > lro there is no way to actually test it and the code will surely bitrot.
> 
> Christoph, you can do LRO pretty much completely in software.
> 
> 
