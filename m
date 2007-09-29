Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 611CCDDE02
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 16:49:30 +1000 (EST)
Date: Sat, 29 Sep 2007 10:49:17 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] cpm: Describe multi-user ram in its own device node.
Message-ID: <20070929104917.1585737e@kernel.crashing.org>
In-Reply-To: <08C0C9CB-C958-4B95-81B8-D0677CBA4399@kernel.crashing.org>
References: <20070928190616.GB20213@loki.buserror.net>
	<20070929003005.59afc2a0@kernel.crashing.org>
	<08C0C9CB-C958-4B95-81B8-D0677CBA4399@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: PowerPC dev list <linuxppc-dev@ozlabs.org>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Kumar,

On Fri, 28 Sep 2007 18:53:38 -0500
Kumar Gala wrote:

> 
> On Sep 28, 2007, at 3:30 PM, Vitaly Bordug wrote:
> 
> > Kumar,
> >
> > Realizing this may suffer a bit from cleanest-dts flame war, but  
> > anyway I pretty much see a lot of
> > sense in getting this in during next merge window. Is this possible?
> 
> Probably, does QE have muram?  I can't keep these things straight.
> 

cpms have dpram, qe has muram. these two are the same stuff in fact. Or you are asking about have QE stuff utilize such a binding at the same pass? 
-- 
Sincerely, Vitaly
