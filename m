Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1C41968847
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Nov 2005 05:13:25 +1100 (EST)
In-Reply-To: <1133275187.2664.32.camel@iho.sysgo.com>
References: <1133275187.2664.32.camel@iho.sysgo.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f3e079332f2f66cb1898b288cf66e5c9@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Tue, 29 Nov 2005 13:13:33 -0500
To: ihornberger@sysgo.com
Cc: linuxppc-devel list <linuxppc-dev@ozlabs.org>
Subject: Re: immap with 8xx.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 29, 2005, at 9:39 AM, Ingo Hornberger wrote:

> But it seems that there was some generalization work done, which didn't
> reach the 8xx part. Particularly this means that some parts of
> 'asm/commproc.h' as well as (at least) 'asm/immap_8260.h' built up a 
> new
> header 'asm/immap_cpm2.h'.

That's because the cpm2 is used in more parts than just the 82xx,
so we carved up the files to make it more useful.

> Actally I miss a file like 'asm/immap_cpm1.h'.

The 8xx is the only processor to use the CPM1, so just update
the immap or 8xx files to accommodate the differences you may
need.  There isn't a similar requirement to create a immap_cpm1.h
file like there was for the CPM2.  What kind of updates do you need?

Thanks.

	-- Dan
