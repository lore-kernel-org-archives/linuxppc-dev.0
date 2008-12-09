Return-Path: <serge@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 56084DDF33
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 08:54:20 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id mB9Lqmgl021916
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Dec 2008 14:52:48 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mB9LsFpT227672
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Dec 2008 14:54:15 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mB9LsBSP029750
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Dec 2008 14:54:14 -0700
Date: Tue, 9 Dec 2008 15:54:06 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [PATCH 6/8] cleanup do_init_bootmem()
Message-ID: <20081209215406.GC24549@us.ibm.com>
References: <20081209182130.DB2150A2@kernel> <20081209182138.12F61BBF@kernel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081209182138.12F61BBF@kernel>
Cc: Jon Tollefson <kniht@linux.vnet.ibm.com>, Mel Gorman <mel@csn.ul.ie>,
	linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Quoting Dave Hansen (dave@linux.vnet.ibm.com):
> 
> I'm debating whether this is worth it. It makes this a bit more clean
> looking, but doesn't seriously enhance readability.  But, I do think
> it helps a bit.
> 
> Thoughts?

Absolutely.  do_init_bootmem_node() is *still* a bit largish,
but far better broken out.
