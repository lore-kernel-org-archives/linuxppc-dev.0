Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5FE40DDF37
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 00:50:03 +1100 (EST)
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [dtc] Remove check for linux,platform property in /chosen 
In-Reply-To: Your message of "Mon, 29 Jan 2007 15:30:59 +1100."
	<20070129043059.GC14216@localhost.localdomain>
References: <20070129043059.GC14216@localhost.localdomain> 
Date: Mon, 29 Jan 2007 07:49:57 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1HBWtR-00006z-9H@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day David Gibson mumbled:
> Jon, please apply:
> 
> The linux,platform property in /chosen was obsolete almost as soon as
> it was invented.  Remove the check for it from dtc, which just tends
> to lead to irritating spurious failures.  
> 
> Signed-off-by: David Gibson <dwg@au1.ibm.com>

Done.

Thanks,
jdl
