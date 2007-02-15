Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7D83BDDEC6
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 08:45:23 +1100 (EST)
Subject: Re: [DTC PATCH] Add support for decimal, octal and binary based
	cell values.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Loeliger <jdl@jdl.com>
In-Reply-To: <E1HHkym-0005u5-HA@jdl.com>
References: <E1HHkAL-0005Xl-2f@jdl.com>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1BB35@az33exm25.fsl.freescale.net>
	<E1HHkym-0005u5-HA@jdl.com>
Content-Type: text/plain
Date: Fri, 16 Feb 2007 08:44:43 +1100
Message-Id: <1171575883.5644.46.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-02-15 at 12:05 -0600, Jon Loeliger wrote:
> So, like, the other day "Yoder Stuart-B08248" mumbled:
> > 
> > I like to see no space between the d#, h#, etc and the
> > numeric value.
> 
> So, that's one of the really nice things about parsers.
> Just do this, then:
> 
>     d23 = <d#23>;		// Just like <d# 23>!
> 
> The real question, though, is this:  MUST the space between
> 'd#' and '23' be removed so that it is all one token?
> I suppose I could repaint that shed if needed, but I 
> don't think it is.

Also, the question is, will the d# affect only the next number or all
the numbers until the next ">" ?

Ben.
