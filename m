Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2C5EDDE055
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 13:29:47 +1000 (EST)
Subject: Re: [PATCH] ppc64: xmon: Add dl command to dump contents of __log_buf
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Vinay Sridhar <vinay@linux.vnet.ibm.com>
In-Reply-To: <200905151443.07723.vinay@linux.vnet.ibm.com>
References: <200905151443.07723.vinay@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Mon, 18 May 2009 13:29:33 +1000
Message-Id: <1242617373.18075.26.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, ellerman@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2009-05-15 at 14:43 +0530, Vinay Sridhar wrote:
> Hello All,
> 
> Quite a while back Michael Ellerman had posted a patch to add support to xmon to print the contents of the console log pointed to by __log_buf.
> Here's the link to that patch - http://ozlabs.org/pipermail/linuxppc64-dev/2005-March/003657.html
> I've ported the patch in the above link to 2.6.30-rc5 and have tested it. 

Thanks, good idea.

I'll review & test and if all goes well, it will be in -next.

Cheers,
Ben
