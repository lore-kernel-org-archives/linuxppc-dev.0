Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 83193DDEF2
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 08:44:20 +1000 (EST)
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2] Allow exec on 32-bit from readable, non-exec pages,
	with a warning.
In-Reply-To: Your message of "Tue, 17 Jul 2007 17:14:56 CDT."
	<469D3F60.8000401@freescale.com>
References: <20070709214853.GA29912@ld0162-tx32.am.freescale.net>
	<1184705168.24473.32.camel@ld0161-tx32>
	<469D3F60.8000401@freescale.com>
Date: Tue, 17 Jul 2007 17:44:14 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IAvmA-00062M-F4@jdl.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

<Top Posting Carnac>

A:  They haven't been posted yet.

Q:  How do we know Segher has new patches?

</Top Posting Carnac>

So, like, the other day Scott Wood mumbled:
> Jon Loeliger wrote:
> > But luckily, this gave me the opportunity to then realize that
> > we should give a great big...
> > 
> > Amen-brother-by: Jon Loeliger <jdl@freescale.com>
> > 
> > to this patch from Scott.
> > 
> > So, an official plea to Paul to apply this to his tree.
> 
> Segher has a newer patch that supersedes this one.  I don't know if he's 
> posted it to the list yet, though.
> 
> -Scott
