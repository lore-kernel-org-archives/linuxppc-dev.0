Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9CD29DDE0E
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jan 2007 10:33:46 +1100 (EST)
In-Reply-To: <20070108221219.GA20375@localhost.localdomain>
References: <OF7EF2F643.75F7008B-ON8625725D.00157658-8625725D.00167CB4@au1.ibm.com>
	<1168236558.22458.187.camel@localhost.localdomain>
	<8ee3d13b73a511a785ac4744c268943e@kernel.crashing.org>
	<1168288352.22458.198.camel@localhost.localdomain>
	<20070108221219.GA20375@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <605f456c7923dacdc3fb6e6fa2a8bde8@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: EMAC OF binding....
Date: Tue, 9 Jan 2007 00:34:05 +0100
To: David Gibson <dwg@au1.ibm.com>
Cc: Christian Rund <Christian.Rund@de.ibm.com>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	Hartmut Penner <HPENNER@de.ibm.com>, Murali N Iyer <mniyer@us.ibm.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> We should really set up a central place to record all these device
> tree nodes and properties we're defining.

I'm in the process of setting up a Wiki to collect
all kinds of OF stuff -- one big goal is to serve
as a 21st century (and more informal) version of
the old OF working group wrt creating bindings, etc.

No idea how it will work out, and it's not there yet,
but we'll see where this goes.  In the meantime, it's
probably easiest for you to put the proposed device
bindings in a text file in your Linux kernel driver
directory.


Segher
