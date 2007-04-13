Return-Path: <linas@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4D51ADDE43
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Apr 2007 02:47:04 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l3DGkxqP006291
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 12:46:59 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3DGkxmV298962
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 12:46:59 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3DGkxHj017460
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 12:46:59 -0400
Date: Fri, 13 Apr 2007 11:46:59 -0500
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] hvc_console polling mode timer backoff
Message-ID: <20070413164659.GY4747@austin.ibm.com>
References: <1176394477.28514.32.camel@farscape.rchland.ibm.com>
	<1176450459.4734.32.camel@concordia.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1176450459.4734.32.camel@concordia.ozlabs.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 13, 2007 at 05:47:39PM +1000, Michael Ellerman wrote:
> 
> I played with this a bit more, and a ~2% increment seems to work nicely.
> It stays low for the first 10-20 seconds, but then approaches the max
> much faster once there's no activity for a while.
> 
> A few examples:
> http://michael.ellerman.id.au/files/cell-backoff.svg

Looks good to me. 

> changed it to use a shift instead of divide. So now it's more like 1.5%,
> but still the point is it increases faster as time passes.

Looks god to me. I suppose

Acked-by: Linas Vepstas <linas@austin.ibm.com> 

is the right thing to say here.

--linas
