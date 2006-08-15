Return-Path: <RAISCH@de.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 357B567B7E
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Aug 2006 21:03:25 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.7/8.13.7) with ESMTP id k7FB3Kt5154574
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Aug 2006 11:03:20 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k7FB79la116810
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Aug 2006 13:07:09 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k7FB3Jbw011763
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Aug 2006 13:03:20 +0200
In-Reply-To: <35786B99AB3FDC45A821572461791973AC87D3@gbrwgceumf01.eu.xerox.net>
Subject: RE: [PATCH 4/6] ehea: header files
To: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
Message-ID: <OF8C6BA147.30EE53F8-ONC12571CB.003C7748-C12571CB.003CBAA4@de.ibm.com>
From: Christoph Raisch <RAISCH@de.ibm.com>
Date: Tue, 15 Aug 2006 13:07:08 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Thomas Q Klein <tklein@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



"Jenkins, Clive" wrote on 15.08.2006 12:53:05:

> > > You mean the eHEA has its own concept of page size? Separate from
> the
> > > page size used by the MMU?
> > >
> >
> > yes, the eHEA currently supports only 4K pages for queues
>
> In that case, I suggest use the kernel's page size, but add a
> compile-time
> check, and quit with an error message if driver does not support it.

eHEA does support other page sizes than 4k, but the HW interface expects to
see 4k pages
The adaption is done in the device driver, therefore we have a seperate 4k
define.


Regards . . . Christoph R.
