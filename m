Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A6669B7B68
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 23 Sep 2009 07:08:32 +1000 (EST)
Subject: Re: powerpc: Move 64bit heap above 1TB on machines with 1TB segments
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mel Gorman <MELGOR@ie.ibm.com>
In-Reply-To: <OFE590BAE9.6FD7FAB3-ON80257639.0050F8A6-80257639.00514A5E@ie.ibm.com>
References: <20090922025235.GD31801@kryten>
	<OFE590BAE9.6FD7FAB3-ON80257639.0050F8A6-80257639.00514A5E@ie.ibm.com>
Content-Type: text/plain
Date: Wed, 23 Sep 2009 07:08:22 +1000
Message-Id: <1253653702.7103.244.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> Unfortunately, I am not sensitive to issues surrounding 1TB segments or how
> they are currently being used. However, as this clearly helps performance
> for large amounts of memory, is it worth providing an option to
> libhugetlbfs to locate 16MB pages above 1TB when they are otherwise being
> unused?

AFAIK, that is already the case, at least the kernel will hand out pages
above 1T preferentially iirc.

There were talks about making huge pages below 1T not even come up
untily you ask for them with MAP_FIXED, dunno where that went.

Cheers,
Ben.
