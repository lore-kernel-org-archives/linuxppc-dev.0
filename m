Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BCD3367D38
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 16:17:04 +1000 (EST)
Subject: Re: [PATCH] update pmac32_defconfig
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olaf@aepfle.de>
In-Reply-To: <20060823060815.GA9071@aepfle.de>
References: <20060821124323.GA28970@aepfle.de>
	<17643.60111.162041.406187@cargo.ozlabs.ibm.com>
	<20060823060815.GA9071@aepfle.de>
Content-Type: text/plain
Date: Wed, 23 Aug 2006 16:16:47 +1000
Message-Id: <1156313807.8433.47.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-08-23 at 08:08 +0200, Olaf Hering wrote:
> On Wed, Aug 23, Paul Mackerras wrote:
> 
> > Olaf Hering writes:
> > 
> > > enable windfarm, pppoe, pegasus, Euro nls and magic sysrq.
> > 
> > Why windfarm?  It doesn't do anything useful on 32-bit machines, not
> > yet anyway...
> 
> I was under the impression that some G4 use this driver.

Nope. Only G5s. I had plans to use the windfarm infrastructure to move
over some of the G4 thermal control code as well but never had the time
to do so.

Ben.
