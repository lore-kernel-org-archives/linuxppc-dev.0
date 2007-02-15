Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id CC9EADDE3B
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 05:03:29 +1100 (EST)
Message-ID: <45D4A049.6060701@freescale.com>
Date: Thu, 15 Feb 2007 12:02:49 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Yoder Stuart-B08248 <stuart.yoder@freescale.com>
Subject: Re: [DTC PATCH] Add support for decimal, octal and binary based cell
	values.
References: <E1HHkAL-0005Xl-2f@jdl.com>	<9696D7A991D0824DBA8DFAC74A9C5FA302A1BB35@az33exm25.fsl.freescale.net>	<20070215180008.GA25247@lixom.net>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1BB49@az33exm25.fsl.freescale.net>
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302A1BB49@az33exm25.fsl.freescale.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Yoder Stuart-B08248 wrote:
> In this case I think it does matter (a little :)).  If
> you represent a number as <#h5678> it's clear that the
> #h and 5678 are related.
> 
> If you represent it as <#h 5678> the relation between
> the two is not as clear-- of course once you read the 
> spec you figure it out.
> 
> It's not a huge deal, but while we're adding a feature
> to dtc why not make the syntax as clear as we can?

It should be noted that the patch Jon posted should accept it either 
with or without the space.

-Scott
