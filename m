Return-Path: <jchapman@katalix.com>
Received: from ptb-relay01.plus.net (ptb-relay01.plus.net [212.159.14.212])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 81B6E67A79
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Feb 2005 20:01:57 +1100 (EST)
Message-ID: <421D97FE.4080100@katalix.com>
Date: Thu, 24 Feb 2005 09:01:50 +0000
From: James Chapman <jchapman@katalix.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
References: <421CEC19.2010703@katalix.com>
	<20050223222534.GM345@smtp.west.cox.net>
In-Reply-To: <20050223222534.GM345@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: PATCH: add ppc PVR register values for 7447A and 7457 CPUs
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tom Rini wrote:

> On Wed, Feb 23, 2005 at 08:48:25PM +0000, James Chapman wrote:
> 
>>Signed-off-by: James Chapman <jchapman@katalix.com>
>>
>>Trivial patch to add 7447A and 7457 CPU defs.
> 
> 
> Why?  Most of the PVR definitions here can be removed (*muttering about
> 85xx ones being added).
> 

I'm in the process of submitting a patch for a new board (Radstone
PPC7D). Since other boards test CPU type using definitions in this file,
I was trying to be consistent.

If the community don't think those definitions are useful, I'll just
move the ones I need into my board support stuff.

-- 
James Chapman
PGP key : http://www.katalix.com/~jchapman/pgpkey.txt
