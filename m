Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id AC886DE024
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 07:40:01 +1100 (EST)
Message-ID: <45BFAD1E.4060605@freescale.com>
Date: Tue, 30 Jan 2007 14:39:58 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 12/18] bootwrapper: Make ft_get_parent() return a phandle,
	and NULL if already top-level.
References: <20070129201211.GL13485@ld0162-tx32.am.freescale.net>
	<55FE15EB-8FA6-4819-B3DE-5F72A423F3CC@kernel.crashing.org>
In-Reply-To: <55FE15EB-8FA6-4819-B3DE-5F72A423F3CC@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>> It also now returns NULL as the parent of the toplevel node, rather  than
>> just returning the toplevel node again (which made it rather  useless in
>> loops).
> 
> 
> Great, that's how "real" OF handles this as well.  In
> a similar vein, peer(0) should return the root node --
> does it?

I don't see any peer() function in the bootwrapper...

-Scott
