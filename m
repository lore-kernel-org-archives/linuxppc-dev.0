Return-Path: <ptich@hotmail.com>
Received: from bay0-omc1-s17.bay0.hotmail.com (bay0-omc1-s17.bay0.hotmail.com
	[65.54.246.89]) by ozlabs.org (Postfix) with ESMTP id 7109E67D18
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 19:14:17 +1100 (EST)
Message-ID: <BAY102-F187E9196477E724317B9C6A9F70@phx.gbl>
In-Reply-To: <1162631980.28571.30.camel@localhost.localdomain>
From: "M Ptich" <ptich@hotmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Low memory not pageable on Freescale BookE
Date: Fri, 10 Nov 2006 08:14:15 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For our application, we need low memory to be mapped with pages, but it 
turned out that Freescale BookE maps it with TLB1. Was there any particular 
reason why ? I am thinking of changing it, but wondering if there was 
something fundamental behind it.

Regards
Ptich

_________________________________________________________________
All-in-one security and maintenance for your PC.  Get a free 90-day trial! 
http://clk.atdmt.com/MSN/go/msnnkwlo0050000002msn/direct/01/?href=http://www.windowsonecare.com/?sc_cid=msn_hotmail
