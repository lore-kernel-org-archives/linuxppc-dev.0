Return-Path: <RAISCH@de.ibm.com>
Received: from mtagate5.de.ibm.com (mtagate5.de.ibm.com [195.212.29.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4E74067B85
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 01:58:28 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.13.7/8.13.7) with ESMTP id k7IFwObS150254
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 15:58:24 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k7IG2IA0147978
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 18:02:18 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k7IFwNe3029182
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 17:58:23 +0200
In-Reply-To: <20060818151340.GB27947@krispykreme>
Subject: Re: [2.6.19 PATCH 2/7] ehea: pHYP interface
To: Anton Blanchard <anton@samba.org>
Message-ID: <OFF0CF1858.B1C22ED6-ONC12571CE.0056FB13-C12571CE.0057BEA6@de.ibm.com>
From: Christoph Raisch <RAISCH@de.ibm.com>
Date: Fri, 18 Aug 2006 18:02:17 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Thomas Q Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>,
	Marcus Eder <meder@de.ibm.com>, tklein@linux.ibm.com,
	Alexey Dobriyan <adobriyan@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>
> Hi,
>
> > I asked SO to recount arguments and we've come to a conclusion that
> > there're in fact 19 args not 18 as the name suggests. 19 args is
> > I-N-S-A-N-E.
>
> It will be partially cleaned up by:
>
> http://ozlabs.org/pipermail/linuxppc-dev/2006-July/024556.html
>
> However it doesnt fix the fact someone has architected such a crazy
> interface :(
>
> Anton


well, just as background info, this is the wrapper around
a single assembly instruction which calls system firmware and takes
9 CPU registers for input and 9 CPU registers for output parameters.
This definition by platform architecture won't change in the near future,
but the good news is with Antons change the wrapper will look much nicer.

Gruss / Regards . . . Christoph R
