Return-Path: <dave@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 353A9DDF84
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 09:54:13 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id mBAMrVq3004110
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 15:53:31 -0700
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mBAMsAB7226824
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 15:54:10 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mBAMs3GH007837
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 15:54:10 -0700
Subject: Re: [PATCH 1/8] fix bootmem reservation on uninitialized node
From: Dave Hansen <dave@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18752.16188.480990.923571@cargo.ozlabs.ibm.com>
References: <20081209182130.DB2150A2@kernel> <20081209182130.1E4C1438@kernel>
	<18752.16188.480990.923571@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Wed, 10 Dec 2008 14:54:00 -0800
Message-Id: <1228949640.9737.109.camel@nimitz>
Mime-Version: 1.0
Cc: Jon Tollefson <kniht@linux.vnet.ibm.com>, Mel Gorman <mel@csn.ul.ie>,
	linuxppc-dev@ozlabs.org, "Serge E. Hallyn" <serue@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-12-11 at 09:14 +1100, Paul Mackerras wrote:
> Dave Hansen writes:
> > This patch ensures that we do not touch bootmem for any node which
> > has not been initialized.
> > 
> > Signed-off-by: Dave Hansen <dave@linux.vnet.ibm.com>
> 
> So, should I be sending this to Linus for 2.6.28?

Yes, this is 2.6.28 material.

> I notice you have added a dbg() call.  For a 2.6.28 patch I'd somewhat
> prefer not to have that in unless necessary.

It isn't necessary and probably snuck in from the others.  I'll respin
and send this one out again.  If you want the others, I'll send
separately.

-- Dave
