Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3E2AD2BC0F
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Oct 2004 09:51:29 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
In-Reply-To: <41742E62.6060603@nortelnetworks.com>
References: <41742E62.6060603@nortelnetworks.com>
Content-Type: text/plain
Message-Id: <1098143214.30522.40.camel@gaston>
Mime-Version: 1.0
Date: Tue, 19 Oct 2004 09:46:54 +1000
Cc: linuxppc-dev@ozlabs.org
Subject: Re: tbr/decrementer and SMP -- do the cpus stay in sync?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2004-10-19 at 06:58, Chris Friesen wrote:
> I thought I remembered some discussion on this a while back, but I can't find it 
> in my archived messages or online, so here goes.
> 
> With SMP PowerPC machines (specifically the dual G5) we sync up the timebase 
> when we bring up the second CPU.  Are we guaranteed that they stay in sync after 
> that point, or will they drift?  If they drift, do we have any idea how much?

Yes. They have the same clock source. They won't drift.
Ben.
