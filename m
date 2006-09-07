Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2C55B67B79
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Sep 2006 10:59:06 +1000 (EST)
Subject: Re: [4/5] powerpc: PA Semi PWRficient platform support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <E2C62E02-AB23-451F-8A82-718A13B675BE@kernel.crashing.org>
References: <20060904175742.5472a6fa@localhost.localdomain>
	<20060905122956.2cebd36d@localhost.localdomain>
	<0C880511-D99D-4160-9EB1-A66B22B2D82F@kernel.crashing.org>
	<20060906101034.404014f7@localhost.localdomain>
	<E2C62E02-AB23-451F-8A82-718A13B675BE@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 07 Sep 2006 10:58:52 +1000
Message-Id: <1157590732.22705.274.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, paulus@samba.org,
	anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-09-06 at 17:26 +0200, Segher Boessenkool wrote:
> >> Very nice, I'll convert maple to do the same (unless someone beats
> >> me to it, heh).
> >
> > Maple isn't that different there. It just has to deal with multiple  
> > ISUs,
> > while we currently only have one.
> 
> Maple has only one as well, that's the point :-)
> It gets the ISU address from that awful platform-open-pic
> property currently, hardcoding it like you did for PA6T is
> just fine though.  It simplifies the code quite a bit and
> doesn't depend on this undocumented (and badly defined no
> matter what) device tree property.

It's perfectly documented :)

Ben.
