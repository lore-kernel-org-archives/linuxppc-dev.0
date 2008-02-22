Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (unknown [192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E402DDE054
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 03:25:44 +1100 (EST)
Date: Fri, 22 Feb 2008 10:08:20 -0600
From: Scott Wood <scottwood@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Add support for binary includes.
Message-ID: <20080222160820.GA19571@ld0162-tx32.am.freescale.net>
References: <20080220191941.GA2062@ld0162-tx32.am.freescale.net>
	<fa686aa40802212205p38c3793bg8793740955b1e91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40802212205p38c3793bg8793740955b1e91@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 21, 2008 at 11:05:58PM -0700, Grant Likely wrote:
> On Wed, Feb 20, 2008 at 12:19 PM, Scott Wood <scottwood@freescale.com> wrote:
> > A property's data can be populated with a file's contents
> >  as follows:
> >
> >  node {
> >         prop = /incbin/("path/to/data");
> >  };
> >
> >  A subset of a file can be included by passing start and size parameters.
> >  For example, to include bytes 8 through 23:
> >
> >  node {
> >         prop = /incbin/("path/to/data", 8, 16);
> >  };
> 
> 
> Can I ask; what is the intended usage of such a thing?  How large
> would a typical binary blob be?

I use it for embedding guest device trees in a hypervisor's device tree.

-Scott
