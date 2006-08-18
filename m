Return-Path: <HNGUYEN@de.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ACBBF67B7A
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 01:39:27 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.7/8.13.7) with ESMTP id k7IFdM7g160708
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 15:39:22 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k7IFhGfh125670
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 17:43:16 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k7IFdL0X023477
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 17:39:21 +0200
In-Reply-To: <200608180134.39050.arnd.bergmann@de.ibm.com>
Subject: Re: [PATCH 13/13] IB/ehca: makefiles/kconfig
To: abergman@de.ibm.com
Message-ID: <OFC07EB1C7.B6C18CC5-ONC12571CE.0056110B-C12571CE.0055FF7C@de.ibm.com>
From: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>
Date: Fri, 18 Aug 2006 17:43:13 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	linuxppc-dev@ozlabs.org, Christoph Raisch <RAISCH@de.ibm.com>,
	Marcus Eder <MEDER@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


abergman@de.ltcfwd.linux.ibm.com wrote on 18.08.2006 01:34:37:

> On Thursday 17 August 2006 22:11, Roland Dreier wrote:
> > +
> > +CFLAGS += -DEHCA_USE_HCALL -DEHCA_USE_HCALL_KERNEL
>
> This seems really pointless, since you're always defining these
> macros to the same value.
>
> Just drop the CFLAGS and remove the code that depends on them
> being different.
Yes, that's true. Those defines are unnecessary. We'll throw them out.
Thx
Hoang-Nam Nguyen
