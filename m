Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 71A4D67A6B
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Mar 2005 04:54:34 +1100 (EST)
In-Reply-To: <4e44f753c3a197eff3b584f24a239f06@freescale.com>
References: <4e44f753c3a197eff3b584f24a239f06@freescale.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a6c94966dfd580730c9b435c0d95deef@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Wed, 16 Mar 2005 12:12:28 -0500
To: Kumar Gala <kumar.gala@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: building ppc_htab?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 16, 2005, at 1:57 AM, Kumar Gala wrote:

> Is there any reason not to make the following change so we build 
> ppc_htab only on PPC STD MMU?  This would also require fixing up 
> fs/proc/proc_misc.c.

Does it actually build properly this way?  There used to be 
functions/variables
defined there, needed for linking resolution at least.  There were also 
some
generally called functions, that usually didn't do anything unless 
there was
a hash table used.  If that is fixed up, then this is fine :-)

Thanks.


	-- Dan
