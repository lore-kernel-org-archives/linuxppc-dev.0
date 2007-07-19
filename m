Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3851ADDED8
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 07:40:36 +1000 (EST)
Subject: Re: [PATCH] Add StorCenter DTS first draft.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <F2806DFF-A43B-4853-A6C0-3D69B0231B06@kernel.crashing.org>
References: <E1IAnwC-0003Xm-6U@jdl.com>
	<1184722754.25235.183.camel@localhost.localdomain>
	<5F6EB5F7-C5AE-437F-9DF1-22FE38D7A841@kernel.crashing.org>
	<1184795678.25235.269.camel@localhost.localdomain>
	<F2806DFF-A43B-4853-A6C0-3D69B0231B06@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 20 Jul 2007 07:39:57 +1000
Message-Id: <1184881198.25235.347.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-07-19 at 19:07 +0200, Segher Boessenkool wrote:
> 
> So your plan is to prefer the device tree over the cputable, and
> maybe even deprecate the cputable?  

Nah, you are fine not putting anything, but if it's in the DT it should
be correct, not "0". Else, just don't put it in the DT.

We use the DT to override cputable but that's mostly useful for things
like pSeries where you can get some processors in "compatibility" mode
over another one, or some virtual PVRs, and other fancy things like that
where the cputable isn't very useful.

Ben.
