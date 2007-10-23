Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 13094DDE99
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 11:09:34 +1000 (EST)
In-Reply-To: <20071023002631.GB31839@localhost.localdomain>
References: <E1IivsP-00078Q-Hf@jdl.com>
	<20071020071920.GF26642@localhost.localdomain>
	<jesl46yxri.fsf@sykes.suse.de>
	<20071020090633.GH26642@localhost.localdomain>
	<E1Ik0UO-000389-AN@jdl.com>
	<20071022115511.0b902044@weaponx.rchland.ibm.com>
	<20071023002631.GB31839@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2c486ee9215910c24e7752580511a3b3@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 3/4] DTC: Appease the printf() format $Gods with a correct
	type.
Date: Tue, 23 Oct 2007 03:03:40 +0200
To: David Gibson <dwg@au1.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Yes, I think %z is preferable.  It used to be a glibc (et al)
> extension, but I think it's now specified in C99 (we should double
> check that).

It is.


Segher
