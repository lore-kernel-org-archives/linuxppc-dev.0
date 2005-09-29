Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A1796683D2
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Sep 2005 22:50:46 +1000 (EST)
In-Reply-To: <433BDCE7.2060206@iki.fi>
References: <DCEAAC0833DD314AB0B58112AD99B93B85946A@ismail.innsys.innovsys.com>
	<4333DF04.3000908@iki.fi> <43395322.1080407@iki.fi>
	<384d09b865d454875c447cc02c89d001@embeddedalley.com>
	<4339AD01.30708@iki.fi>
	<714c16295fbfa97caafd1d0aa3a5932e@embeddedalley.com>
	<433A6E6D.4070403@iki.fi> <433BDCE7.2060206@iki.fi>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <30a4271599a05b56b51b6c3e03cb1b70@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 29 Sep 2005 08:50:49 -0400
To: Kalle Pokki <kalle.pokki@iki.fi>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: CPM2 early console
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Sep 29, 2005, at 8:24 AM, Kalle Pokki wrote:

> flags |= _PAGE_WRITETHRU | _PAGE_COHERENT;
>
> in setbat() in arch/ppc/mm/ppc_mmu.c. But this should not depend on 
> this kind of a hack, should it?

This is clearly wrong since other 82xx processors work fine.  Something
is amiss with your boot rom or other setup of this processor.

Thanks.

	-- Dan
