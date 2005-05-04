Return-Path: <cfriesen@nortel.com>
Received: from zcars04e.ca.nortel.com (zcars04e.nortelnetworks.com
	[47.129.242.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ADA71679F0
	for <linuxppc-dev@ozlabs.org>; Thu,  5 May 2005 02:07:01 +1000 (EST)
Message-ID: <4278F314.6080304@nortel.com>
Date: Wed, 04 May 2005 10:06:44 -0600
From: Chris Friesen <cfriesen@nortel.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
References: <17016.29775.224816.691409@cargo.ozlabs.ibm.com>	<466e699745cf24e660e296530f6e34dc@embeddededge.com>
	<20050504153419.GV1221@smtp.west.cox.net>
In-Reply-To: <20050504153419.GV1221@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Set cpu explicitly in kernel compiles
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tom Rini wrote:

> Since there are folks working on optimizing toolchains on at least some
> of the newer CPUs, I'd be inclined to say we should do something like
> cpu-opt-y := ... gcc-3.3.x defaults ...
> cpu-opt-$(CONFIG_6xx) := -mcpu=750 -mtune=7450
> cpu-opt-$(CONFIG_8xx) := -mcpu=800 -mtune=800 # Or whatever it is..

While you're at it, how about breaking out the 970 as separate from the 
POWER4?

Chris
