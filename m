Return-Path: <linas@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 748F267BCD
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 07:52:58 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7NLqs6j014909
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 17:52:55 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7NLqlSb255424
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 17:52:47 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7NLqlfO019944
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 17:52:47 -0400
Date: Wed, 23 Aug 2006 16:52:46 -0500
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 5/6]: powerpc/cell spidernet bottom half
Message-ID: <20060823215246.GH4401@austin.ibm.com>
References: <20060818220700.GG26889@austin.ibm.com>
	<20060818222657.GL26889@austin.ibm.com>
	<200608190103.05649.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200608190103.05649.arnd@arndb.de>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: akpm@osdl.org, netdev@vger.kernel.org, James K Lewis <jklewis@us.ibm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	ens Osterkamp <Jens.Osterkamp@de.ibm.com>, Jeff Garzik <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Aug 19, 2006 at 01:03:04AM +0200, Arnd Bergmann wrote:
> using the NAPI poll function

Still fiddling with this. Getting side-tracked after noticing
that the RX side generates a *huge* numbe of interrupts, despite
code in the driver which superficially appears to be RX NAPI.  
One step forward, two steps back, isn't there a dance like that?

--linas
