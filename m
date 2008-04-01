Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4950BDDEFD
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 11:18:24 +1000 (EST)
In-Reply-To: <20080331164302.GC13750@farnsworth.org>
References: <20080328233954.GA29499@farnsworth.org>
	<20080328234900.GF30214@farnsworth.org>
	<20080329215942.GB27226@lixom.net>
	<20080330101128.GA20077@localhost.localdomain>
	<20080331164302.GC13750@farnsworth.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0f87ab96ae7a7d4cc0b0337c60ee2ab6@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 6/9] [POWERPC] prpmc2800: clean up dts properties
Date: Tue, 1 Apr 2008 03:17:52 +0200
To: Dale Farnsworth <dale@farnsworth.org>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> However, I can't resist pointing out that in the existing devtrees
> with a "soc" node, the name is also misleading.  That node doesn't
> refer to the SOC itself, but to the part of the SOC containing the
> peripherals.  Whether the system is implemented on one or two chips
> is an implementation detail irrelevant to the drivers or device tree.

It's not ideal to call it "the-perhaps-virtual-bus-on-the-soc-that-
contains-all-of-the-register-blocks-for-all-the-devices-on-the-soc-
except-some" either.  A better name is welcome of course.

Maybe it's best to name this node with the name _of_ the SoC (or host
bridge, or what ever you want to call it), if that name is not too
unwieldy.

In general, "name" should be as generic as is useful, but not more
generic than that, because it wouldn't be useful anymore.

In any case, it's just "name", it should normally only be looked at
by humans.  Use whatever you like best here, and don't use it in the
kernel code.


Segher
