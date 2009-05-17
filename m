Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A5918DE061
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 08:01:29 +1000 (EST)
Subject: Re: [PATCH] [PowerPC] Support For Initrd Loaded Into Highmem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20090517133417.9E0FC832E416@gemini.denx.de>
References: <4A103EDF.7050108@ru.mvista.com>
	<20090517133417.9E0FC832E416@gemini.denx.de>
Content-Type: text/plain
Date: Mon, 18 May 2009 07:56:17 +1000
Message-Id: <1242597377.18075.1.camel@pasglop>
Mime-Version: 1.0
Cc: Konstantin Baydarov <kbaidarov@ru.mvista.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> >   How Solved:
> > Code was added that checks if initrd is in the highmem and relocates initrd
> > into lowmem if required.
> 
> I don't think this is needed. Just don't load the ramdisk to highmem
> in the first place.

Well, it does make some sense to avoid the kernel eating itself if
passed things out of lowmem in the reserve map, though Konstantin patch
doesn't fix that properly, I think it's still something to look into.

Cheers,
Ben.
