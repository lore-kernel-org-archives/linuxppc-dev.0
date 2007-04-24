Return-Path: <RAISCH@de.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.29.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C32C3DDF01
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 17:49:14 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.8/8.13.8) with ESMTP id l3O7n8Pl028210
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 07:49:08 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l3O7n8Uw3686538
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 09:49:08 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l3O7n7lJ026456
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 09:49:07 +0200
In-Reply-To: <1177347358.28021.24294.camel@hal.voltaire.com>
Subject: Re: [ofa-general] [PATCH] eHCA: Add "Modify Port" verb
To: Hal Rosenstock <halr@voltaire.com>
Message-ID: <OFD6A63EF5.4BF41EFD-ONC12572C7.002ACA29-C12572C7.002AF268@de.ibm.com>
From: Christoph Raisch <RAISCH@de.ibm.com>
Date: Tue, 24 Apr 2007 23:48:48 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	general-bounces@lists.openfabrics.org, Joachim Fenkes <fenkes@de.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	OF-General <general@lists.openfabrics.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi Hal,
you are correct,
with the current firmware version it will fail later.

Christoph R.

general-bounces@lists.openfabrics.org wrote on 23.04.2007 18:55:59:

> Hi Joachim,
>
> On Mon, 2007-04-23 at 12:23, Joachim Fenkes wrote:
> > Add "Modify Port" verb support to eHCA driver.
> > ib_cm needs this to initialize properly.
>
> I didn't think IB_PORT_SM was allowed (as QP0 is not exposed) or does
> this just fail later when it is attempted to be actually set ?
>
> -- Hal
