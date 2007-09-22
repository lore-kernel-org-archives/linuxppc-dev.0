Return-Path: <satyam@infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2F9CDDDE0F
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Sep 2007 16:48:51 +1000 (EST)
Date: Sat, 22 Sep 2007 12:21:42 +0530 (IST)
From: Satyam Sharma <satyam@infradead.org>
To: Mel Gorman <mel@skynet.ie>
Subject: Re: 2.6.23-rc6-mm1: Build failures on ppc64_defconfig
In-Reply-To: <alpine.LFD.0.999.0709201903180.17093@enigma.security.iitk.ac.in>
Message-ID: <alpine.LFD.0.999.0709221221060.22517@enigma.security.iitk.ac.in>
References: <20070918011841.2381bd93.akpm@linux-foundation.org>
	<20070920132512.GF24105@skynet.ie>
	<alpine.LFD.0.999.0709201903180.17093@enigma.security.iitk.ac.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Thu, 20 Sep 2007, Satyam Sharma wrote:
> 
> BTW ppc64_defconfig didn't quite like 2.6.23-rc6-mm1 either ...
> IIRC I got build failures in:

> drivers/md/raid6int8.c

This turned out to be a gcc bug -- I was using an old cross-compiler.
