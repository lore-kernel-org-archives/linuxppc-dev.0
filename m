Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8FFB267BAC
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 17:13:15 +1000 (EST)
Subject: Re: [PATCH] enable RTAS /proc for PowerPC/CHRP platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sven Luther <sven.luther@wanadoo.fr>
In-Reply-To: <20061020065849.GA17286@powerlinux.fr>
References: <4535C0F8.1070905@bplan-gmbh.de>
	<1161152109.7906.6.camel@localhost.localdomain>
	<20061018073851.GA13083@aepfle.de>
	<1161211083.10524.13.camel@localhost.localdomain>
	<20061019070318.GA24642@aepfle.de>
	<1161300942.10524.64.camel@localhost.localdomain>
	<20061020054434.GC3277@aepfle.de>
	<1161323797.10524.150.camel@localhost.localdomain>
	<20061020062431.GB14390@powerlinux.fr>
	<20061020064456.GA3946@aepfle.de>
	<20061020065849.GA17286@powerlinux.fr>
Content-Type: text/plain
Date: Fri, 20 Oct 2006 17:12:52 +1000
Message-Id: <1161328372.10524.170.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: akpm@osdl.org, Olaf Hering <olaf@aepfle.de>, Sven Luther <sl@bplan-gmbh.de>,
	tilmann@bitterberg.de, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Exact, it is not about poluting, but about rationalizing. The fact is that
> these are the two infos that are the most necessary to userland, then why
> disseminate the info in thousand different places, instead of making it easily
> available in a canonical place in a standard format for everyone ? 

Why would that be absolutely necessary to userland ? We've lived very
well without that so far.
 
> > About 32bit/64bit, maybe VmallocTotal from /proc/meminfo can be used.
> > incredible large numer == must be a 64bit kernel
> > No idea how reliable it is. There are those 36bit systems, but I bet
> > they dont run a distro.
> 
> This sounds like the ugliest hack i have seen around, and is prone to break. A
> proper /proc/cpuinfo flag would be most welcome to solve this cleanly.

uname is your friend... damn, and if you want to be real sure, then just
try to run a 64 bits binary and see what happens :)

Ben.
