Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3C50CDDF10
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 23:32:12 +1000 (EST)
In-Reply-To: <20070904002745.GB20549@localhost.localdomain>
References: <20070831175006.17240@gmx.net>
	<20070903013431.GG31499@localhost.localdomain>
	<1188808900.5972.133.camel@localhost.localdomain>
	<ad58529dfd4a248ab904c2c5871258bf@kernel.crashing.org>
	<20070903101234.GA12212@localhost.localdomain>
	<20070903161156.306700@gmx.net>
	<6858c7a36ed061265937daa7b14cc5ac@kernel.crashing.org>
	<20070904002745.GB20549@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <fa2c500df631fc09cd1dfe00a007c36c@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] AmigaOne device tree source v2
Date: Thu, 6 Sep 2007 15:31:52 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Hrm.. IIRC, it is permissible under Linux to only include device nodes
> for those PCI devices where something must be specified which can't be
> proved via PCI.

It is.  It isn't clear (to me, at least) which properties are
required in a PCI node that exists for e.g. interrupt reasons
only; or how the kernel decides if a PCI node is a "real" PCI
node (i.e., using the PCI binding), or an "empty" PCI node.


Segher
