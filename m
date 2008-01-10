Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 2/3] Look for include files in the directory of the
	including file.
In-Reply-To: Your message of "Thu, 10 Jan 2008 14:52:01 +1100."
	<20080110035201.GJ17816@localhost.localdomain>
References: <20080103234331.GB8441@ld0162-tx32.am.freescale.net>
	<20080104042739.GC4326@localhost.localdomain>
	<20080106225252.GB8239@ld0162-tx32.am.freescale.net>
	<20080110035201.GJ17816@localhost.localdomain>
Date: Thu, 10 Jan 2008 08:25:18 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1JCyLO-00072t-Vi@jdl.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day David Gibson mumbled:
> > The doubly-linked list is intended to make it easier to construct search
> > path lists one-at-a-time from arguments in the proper order, without
> > needing to reverse the list at the end.
> 
> We've already got that problem with a bunch of the lists we create
> during parsing (we have several ugly add-to-end-of-singly-linked-list
> functions).  Going to doubly-linked lists might not be a bad idea, but
> we should do it across the board, probably using the kernel's list.h
> or something like it.

I would be happy to accept a kernel's-list.h-based refactoring
for doubly linked lists after the imminent 1.1 release!

jdl
