Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D6340DDF27
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 03:55:28 +1000 (EST)
In-Reply-To: <48808914.20702@genesi-usa.com>
References: <20080715100033.GA5147@iram.es> <487CC1F5.5090706@genesi-usa.com>
	<20080715155944.GA11881@iram.es> <48808914.20702@genesi-usa.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c331742b5952510a9bce5e654ba293b4@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: 2.6.26 does not boot on Pegasos
Date: Tue, 22 Jul 2008 19:54:57 +0200
To: Matt Sealey <matt@genesi-usa.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> If you built this kernel yourself, you need to do it from a system 
>>> with
>>> an up-to-date binutils (2.18) otherwise, it does this.
>
> Note to the linux-ppc guys; is there any changelog entry which reports
> this requirement somewhere? I didn't find one...

That's because there is no such requirement.  2.18 is the latest
version, so it's always wise to test with that in case you have
some problems; but it wouldn't be nice if the kernel can be built
with only one binutils major version.

Please try my build patch for a similar problem, it went into
BenH's tree today.  Would be nice if it was the same problem;
if not, send a proper, _detailed_ bug report here and I'll look
into it.


Segher
