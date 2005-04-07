Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D982967A6C
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Apr 2005 09:43:42 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <jer7hm6unm.fsf@sykes.suse.de>
References: <1112594783.26086.22.camel@gaston>
	<1112616384.19004.60.camel@gaston> <jezmwa6y4i.fsf@sykes.suse.de>
	<1112913519.9568.295.camel@gaston>  <jer7hm6unm.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Fri, 08 Apr 2005 09:42:33 +1000
Message-Id: <1112917354.9517.333.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: iBook G3 owners
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2005-04-08 at 01:20 +0200, Andreas Schwab wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > I know, but this oneliner is incorrect. It can't be correct, no way.
> > That is very strange, and that's what I'm trying to figure out. Can you
> > try instead changing the start address of the flush from 0xfff00000 to 0
> > by changing the L1 flush bit initalisation from lis r4,0xfff0 to li
> > r4,0 ?
> 
> This fixes the problem.

Ok, I still don't have anything like a good explanation of why this
fixes it, but it's a better workaround for now.

Ben.
