Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6E2C6DE4E0
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 13:52:42 +1100 (EST)
Subject: Re: [PATCH 0/2] oprofile support for ppc750
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Octavian Purdila <opurdila@ixiacom.com>
In-Reply-To: <1231246535-13151-1-git-send-email-opurdila@ixiacom.com>
References: <1231246535-13151-1-git-send-email-opurdila@ixiacom.com>
Content-Type: text/plain
Date: Wed, 07 Jan 2009 13:52:34 +1100
Message-Id: <1231296754.14860.51.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2009-01-06 at 14:55 +0200, Octavian Purdila wrote:
> Adds oprofile support for ppc750. ppc750 performance counters
> interface is similar with G4, but it only has 4 performance counters
> instead of 6.
> 
> I tested this on a PPC750GX and it seems to work fine. 

I'm not too sure about using the same model as 74xx... I have some
patches that haven't been released yet from Jack Miller to implement the
full OP support for 750 but they appear to cause crashes.

There is a known HW bug in various 750's that basically make the
performance interrupt unuseable. I -think- it may have been fixed in the
very latest revision of the 750CL though but I'm not sure.

Cheers,
Ben.
