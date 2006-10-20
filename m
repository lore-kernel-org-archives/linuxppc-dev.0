Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8FCC267B9E
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 18:17:26 +1000 (EST)
Subject: Re: [PATCH] enable RTAS /proc for PowerPC/CHRP platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sven Luther <sven.luther@wanadoo.fr>
In-Reply-To: <20061020073653.GB17286@powerlinux.fr>
References: <20061018073851.GA13083@aepfle.de>
	<1161211083.10524.13.camel@localhost.localdomain>
	<20061019070318.GA24642@aepfle.de>
	<1161300942.10524.64.camel@localhost.localdomain>
	<20061020054434.GC3277@aepfle.de>
	<1161323797.10524.150.camel@localhost.localdomain>
	<20061020062431.GB14390@powerlinux.fr>
	<20061020064456.GA3946@aepfle.de>
	<20061020065849.GA17286@powerlinux.fr>
	<1161328372.10524.170.camel@localhost.localdomain>
	<20061020073653.GB17286@powerlinux.fr>
Content-Type: text/plain
Date: Fri, 20 Oct 2006 18:16:49 +1000
Message-Id: <1161332209.10524.187.camel@localhost.localdomain>
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


> Why not say it directly in a standard way ? So we avoid all distros and/or
> different tools who need to know, to implement their own slightly different
> way ? 

There is a standard way... uname

Ben.
