Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C2E8BDDD09
	for <linuxppc-dev@ozlabs.org>; Mon,  7 May 2007 20:38:08 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l479aW5X008517
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 05:36:32 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l47Ac4Zv517224
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 06:38:04 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l47Ac4pG026457
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 06:38:04 -0400
Subject: Re: [PATCH v2 4/7] Add support for 750CL Holly board
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17982.43385.49199.628627@cargo.ozlabs.ibm.com>
References: <1178381611.3393.25.camel@zod.rchland.ibm.com>
	<1178381871.3393.32.camel@zod.rchland.ibm.com>
	<17982.43385.49199.628627@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Mon, 07 May 2007 05:32:33 -0500
Message-Id: <1178533953.3393.66.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-05-07 at 14:22 +1000, Paul Mackerras wrote:
> Josh Boyer writes:
> 
> > +config HOLLY
> 
> That's a bit too non-specific, I think; please make it PPC_HOLLY.

Ok.

josh
