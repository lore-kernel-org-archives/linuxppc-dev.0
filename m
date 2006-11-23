Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6E55D67BED
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Nov 2006 01:39:17 +1100 (EST)
In-Reply-To: <F14C95DA-2BC6-4922-B995-ECC6CDB8306E@kernel.crashing.org>
References: <1164208814.1954.372.camel@goblue>
	<AA60A1D7-D271-4CE1-A39F-2CE9F605DB16@kernel.crashing.org>
	<1164211565.4932.7.camel@otta>
	<F14C95DA-2BC6-4922-B995-ECC6CDB8306E@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <dd0612b3528010d6e73a64fa5eaf05c2@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] CAS DFP support
Date: Thu, 23 Nov 2006 15:39:12 +0100
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Also, I think the 602 (may have never seen the light of day)

I never saw any 602 in the wild, and no one I ever asked has.

> only  implemented single precision floating point.

Actually, it implements double precision just fine (although
all double precision arithmetic operations trap and have to
be emulated).  Loads and stores work, the FPRs are 64 bit.

Anyway, off-topic, and this CPU doesn't actually exist anyway.


Segher
