Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A530A67A6C
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Mar 2005 18:31:33 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sven Luther <sven.luther@wanadoo.fr>
In-Reply-To: <20050308064945.GC27722@pegasos>
References: <422C495B.8090805@katalix.com>
	<20050307125808.6585A200008A@mwinf0308.wanadoo.fr>
	<20050307225401.GA31041@xyzzy>  <20050308064945.GC27722@pegasos>
Content-Type: text/plain
Date: Tue, 08 Mar 2005 18:27:12 +1100
Message-Id: <1110266832.13607.267.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Dale Farnsworth <dale@farnsworth.org>, Nicolas DET <det.nicolas@free.fr>
Subject: Re: mv643xx_eth SA_SHIRQ support patch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Notice that benh is telling me that you should use SA_SHIRQ always and that
> SA_INTERRUPT should go away, and that you should contact him online if you
> have trouble with that.
> 
> > For the pegasos 2, you'll need the second patch which applies after
> > the one I previously sent for chrp_setup.c.
> 
> Ok, will test this anyway, and tell you how it works.

GHeh, ok, just picked up the discussion. Yes, there is really no reason
to use SA_INTERRUPT here, this is a thing of the past.

Ben.
