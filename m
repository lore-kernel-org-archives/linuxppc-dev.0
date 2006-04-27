Return-Path: <SRS0+07d864b7556a9b352246+977+infradead.org+hch@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CED4367A3B
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 21:59:25 +1000 (EST)
Date: Thu, 27 Apr 2006 12:59:15 +0100
From: Christoph Hellwig <hch@infradead.org>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Subject: Re: [PATCH 03/16] ehca: structure definitions
Message-ID: <20060427115915.GA15520@infradead.org>
References: <4450A16D.7000008@de.ibm.com>
	<20060427115749.GD32127@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060427115749.GD32127@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	linuxppc-dev@ozlabs.org, Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 27, 2006 at 01:57:49PM +0200, J?rn Engel wrote:
> On Thu, 27 April 2006 12:48:13 +0200, Heiko J Schick wrote:
> > +
> > +#ifdef CONFIG_PPC64
> > +#include "ehca_classes_pSeries.h"
> > +#endif
> 
> Is the #ifdef necessary?  Such conditions around header includes often
> indicate problems with the included header.  If that is the case here,
> you should fix the header in question in a seperate patch.

The real question is what is that ifdef for at all?  The code subitted
isn't built on anything but ppc64.
