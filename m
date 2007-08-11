Return-Path: <schwidefsky@de.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 33927DDE40
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Aug 2007 18:53:02 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id l7B8qwma168602
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Aug 2007 08:52:58 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.4) with
	ESMTP id l7B8qwwt2125986
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Aug 2007 10:52:58 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l7B8qtrx015860
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Aug 2007 10:52:55 +0200
Subject: Re: 2.6.23-rc2-mm2 build error on MIPS and ARM
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
In-Reply-To: <20070811025802.GA15885@Krystal>
References: <20070811025802.GA15885@Krystal>
Content-Type: text/plain
Date: Sat, 11 Aug 2007 10:56:36 +0200
Message-Id: <1186822596.25775.2.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Reply-To: schwidefsky@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-08-10 at 22:58 -0400, Mathieu Desnoyers wrote:
> I got the following errors when building 2.6.23-rc2-mm2 on both mips and
> arm. Both errors are very much alike.

Four letter words. Seems like I have install some more cross-compilers
to find all the compile problems with the mm_types move.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
