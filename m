Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1CFA4DDE0C
	for <linuxppc-dev@ozlabs.org>; Mon, 28 May 2007 21:15:52 +1000 (EST)
Subject: Re: Fix problems with Holly's DT representation of ethernet PHYs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <707c0e95390db3244bf6ebc0cbe95454@kernel.crashing.org>
References: <20070524041625.GD20078@localhost.localdomain>
	<BB9A8C3A-0BC5-4DF0-9201-2742124A4AF5@kernel.crashing.org>
	<1180014260.3360.14.camel@zod.rchland.ibm.com>
	<20070525042359.GE13575@localhost.localdomain>
	<20070525043728.GG13575@localhost.localdomain>
	<20070525043852.GH13575@localhost.localdomain>
	<25433b8fc06678e73ee055ed4f44f7a3@kernel.crashing.org>
	<20070527233031.GB23768@localhost.localdomain>
	<1180316317.19517.51.camel@localhost.localdomain>
	<707c0e95390db3244bf6ebc0cbe95454@kernel.crashing.org>
Content-Type: text/plain
Date: Mon, 28 May 2007 21:15:32 +1000
Message-Id: <1180350932.19517.84.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Alexandre Bounine <Alexandre.Bounine@tundra.com>,
	David Gibson <dwg@au1.ibm.com>, linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-05-28 at 13:07 +0200, Segher Boessenkool wrote:
> > In that case however, the 54xx are fairly different from each other, so
> > please use something more specific.
> 
> _Never_ use the "xx" stuff, it's meaningless.

Pretty much yeah... either you are compatible with a precise version
(the first one of the serie, like an hypothetical 5400) or you are not
in which case you have your precise model name in there.

Ben.
