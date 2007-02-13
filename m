Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BE5CCDDEC2
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 04:44:48 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1DHijS3019923
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 12:44:45 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1DHijwQ543676
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 10:44:45 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1DHihXs030855
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 10:44:44 -0700
Subject: Re: [PATCH 6/16] Port 44x MMU definitions to ARCH=powerpc
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>
In-Reply-To: <adafy9am14g.fsf@cisco.com>
References: <20070213061024.B4A8CDDD0D@ozlabs.org>
	<1171347875.20192.63.camel@localhost.localdomain>
	<adafy9am14g.fsf@cisco.com>
Content-Type: text/plain
Date: Tue, 13 Feb 2007 11:45:41 -0600
Message-Id: <1171388741.4003.55.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: David Gibson <david@gibson.dropbear.id.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-02-13 at 09:13 -0800, Roland Dreier wrote:
>  > > +typedef unsigned long long phys_addr_t;
>  > > +extern phys_addr_t fixup_bigphys_addr(phys_addr_t, phys_addr_t);
>  > > +#define PHYS_FMT	"%16Lx"
>  > 
>  > Do we still need that fixup code ? Since we now have full 64 bits
>  > capable ioremap, we don't need to play tricks anymore. I'd rather get
>  > rid of them completely.
> 
> Maybe make the fixup code print a warning when it actually changes an
> address below 4G so we can track down all the places relying on this?

That sounds like a good idea.  As boards get ported over, the authors
will hopefully fix them up.

josh
