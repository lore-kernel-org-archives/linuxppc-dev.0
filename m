Return-Path: <pochini@denise.shiny.it>
Received: from denise.shiny.it (denise.shiny.it [194.20.232.1])
	by ozlabs.org (Postfix) with ESMTP id 4C7FF687DE
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Dec 2005 02:14:01 +1100 (EST)
Date: Fri, 2 Dec 2005 16:06:19 +0100 (CET)
From: Giuliano Pochini <pochini@denise.shiny.it>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1133146369.7768.170.camel@gaston>
Message-ID: <Pine.LNX.4.58.0512021604360.23144@denise.shiny.it>
References: <20051126113805.709ee538.pochini@shiny.it>
	<17290.26688.710369.613144@cargo.ozlabs.ibm.com>
	<1133146369.7768.170.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
Subject: Re: CPU off power consumption
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Mon, 28 Nov 2005, Benjamin Herrenschmidt wrote:

> No, I think CPUs that have not been started are held in a similar sleep
> loop in ROM. I don't see right away why there would be any power
> consumption difference unless some bug causing us to never actually call
> the sleep loop ....

Any hint on how to debug it ?  Where is the code that enables/disables the
cpus ?  Where is the sleep loop ?


--
Giuliano.
