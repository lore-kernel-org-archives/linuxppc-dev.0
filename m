Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 56D13DDE3B
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 07:25:25 +1100 (EST)
Subject: Re: copy_from_user problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Maynard Johnson <maynardj@us.ibm.com>
In-Reply-To: <47C5574D.2090409@us.ibm.com>
References: <47C36FBA.1030600@us.ibm.com>
	<1203994599.15052.84.camel@pasglop> <47C426F8.7070203@us.ibm.com>
	<1204068146.15052.188.camel@pasglop>  <47C5574D.2090409@us.ibm.com>
Content-Type: text/plain
Date: Thu, 28 Feb 2008 07:24:51 +1100
Message-Id: <1204143891.15052.244.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-02-27 at 06:27 -0600, Maynard Johnson wrote:
> Can't do that in the "real" code I'm developing, so I guess I'll need to 
> use get_user_pages.  Hmmm . . . not quite as simple to use as 
> copy_from_user, and I don't see any doc on it.  But at least I've found 
> a couple examples in the kernel tree.

We can help you if you tell us more about the "real" code.

Ben.
