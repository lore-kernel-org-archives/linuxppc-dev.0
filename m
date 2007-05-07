Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 62979DDEEB
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 05:33:21 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l47JTvaH021014
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 15:29:57 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l47JXG9V171974
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 13:33:16 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l47JXGjR001438
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 13:33:16 -0600
Subject: Re: [PATCH v3 4/7] Add support for 750CL Holly board
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
In-Reply-To: <1178562159.2990.119.camel@zod.rchland.ibm.com>
References: <1178549324.2990.52.camel@zod.rchland.ibm.com>
	<1178549604.2990.62.camel@zod.rchland.ibm.com>
	<1178562159.2990.119.camel@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Mon, 07 May 2007 14:27:41 -0500
Message-Id: <1178566061.2990.144.camel@zod.rchland.ibm.com>
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

On Mon, 2007-05-07 at 13:22 -0500, Josh Boyer wrote:
> On Mon, 2007-05-07 at 09:53 -0500, Josh Boyer wrote:
> > Add PowerPC 750 Holly/Hickory platform support
> > 
> 
> > +
> > +#define HOLLY_PCI_CFG_PHYS 0x7e000000
> 
> FYI this is the wrong address.  Should be 0x7e000000.  It's part of the

ARGH.  0x7c000000

josh
