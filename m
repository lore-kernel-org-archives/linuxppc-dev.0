Return-Path: <sjmunroe@us.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 669B2DDFE4
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 07:41:57 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4ULfseX029916
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 17:41:54 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4ULfrq6515972
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 17:41:53 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4ULfrnU019948
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 17:41:53 -0400
In-Reply-To: <20070530210212.GB4510@iram.es>
Subject: Re: Saving to 32 bits of GPRs in signal context
To: Gabriel Paubert <paubert@iram.es>
Message-ID: <OF0841F19C.9D8F7FDD-ON862572EB.0076CCA6-862572EB.00772DE5@us.ibm.com>
From: Steve Munroe <sjmunroe@us.ibm.com>
Date: Wed, 30 May 2007 16:41:45 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Gabriel Paubert <paubert@iram.es> wrote on 05/30/2007 04:02:12 PM:

>
> In 32 bit mode, 64 bit divides use a libcall for example. But the
> libgcc routine can and should use the 64 bit instructions. There are
> many other libcall cases that would benefit from a libgcc compiled
> to use 64 bit instructions (64 bit int to floating point conversions and
> back). This indirectly affects a lot of functions.
>

That is not an issue. The ISA 2.0 removed the useage restriction for fctid,
fctidz, and fcfid in 32-bit implementations.
