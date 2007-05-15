Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 79321DDED8
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 17:08:22 +1000 (EST)
In-Reply-To: <20070515065826.GF6998@localhost.localdomain>
References: <20070515020026.GG565@localhost.localdomain>
	<8492e53122b6e1ba269afd53b48a4968@kernel.crashing.org>
	<20070515054758.GC6998@localhost.localdomain>
	<200705150811.09927.sr@denx.de>
	<20070515061855.GD6998@localhost.localdomain>
	<1950a79f97480ba96f1b00352ec449a5@kernel.crashing.org>
	<20070515063408.GE6998@localhost.localdomain>
	<5c785f662c13fdd938d48e40d3107050@kernel.crashing.org>
	<20070515065826.GF6998@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e909c6361f679071300958431723d8be@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Small fixes for the Ebony device tree
Date: Tue, 15 May 2007 09:07:52 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Sod it, I think I'll just drop everything except "ibm,sdram-440gp" for
> now.

Perfect plan :-)  And then 440GX, GR, etc. can claim
compatibility to 440GP, which is the nestor of the
family.

> If some later driver has to have an extra backwards
> compatibility id_table entry for the Ebony/440GP it's no great
> disaster.

Sure, mistakes happen.  They can be fixed in the
bootwrapper, too -- or just in the DTS file if your
device tree is shipped with the kernel.


Segher
