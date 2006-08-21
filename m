Return-Path: <RAISCH@de.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.29.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3D69667BAE
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 22:55:56 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.7/8.13.7) with ESMTP id k7LCtoc0032636
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 12:55:50 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k7LCxnb6118334
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 14:59:49 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k7LCtnQh025415
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 14:55:49 +0200
In-Reply-To: <1156164265.9855.196633.camel@hal.voltaire.com>
Subject: Re: [openib-general] [PATCH 08/13] IB/ehca: qp
To: Hal Rosenstock <halr@voltaire.com>
Message-ID: <OFD6EEAEDC.E8A6DA73-ONC12571D1.0046AAD5-C12571D1.0047061E@de.ibm.com>
From: Christoph Raisch <RAISCH@de.ibm.com>
Date: Mon, 21 Aug 2006 14:59:39 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	linuxppc-dev@ozlabs.org, Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>,
	Marcus Eder <MEDER@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>
> I, for one, was hoping that the timer based transition to active for QP1
> would have been resolved before being submitted. Any idea on the plan to
> resolve this ?
>
> -- Hal
>
>
>
We're testing it. As I mentioned before, this requires a change in the
system firmware. I personally don't think this will show up in firmware in
time for 2.6.19 merge window.
So unfortunately we still need that loop.

Regards . . . Christoph R
