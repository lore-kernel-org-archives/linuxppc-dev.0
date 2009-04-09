Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 17D25DE1EE
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Apr 2009 09:20:10 +1000 (EST)
In-Reply-To: <20090410091149.5068d8e1.sfr@canb.auug.org.au>
References: <2c4bcf8d1d7083ff53ce5b556765e96676a007fb.1239165378.git.tony@bakeyournoodle.com>
	<1239167335.10104.26.camel@localhost>
	<20090408055126.GG16602@bilbo.ozlabs.org>
	<7ED93BB3-FE0E-4102-89FB-78950A533717@kernel.crashing.org>
	<20090409224553.GO16602@bilbo.ozlabs.org>
	<20090410091149.5068d8e1.sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1AAD5906-66FA-4850-8C62-8C030816E44E@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Quieten arch/powerpc in a allmodconfig build.
Date: Fri, 10 Apr 2009 01:23:20 +0200
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Unfortunately -Wno-uninitialized also suppresses the warnings that  
> point
> to real bugs.

It's a double-edged sword, yes.  Warnings are always like that:
if the compiler could know that something _is_ wrong for certain,
it wouldn't need a warning (it would use an error, instead -- and
it does do this in certain cases); if it would know something is
not really wrong, it would just shut up.

> (but, I guess, the -Wesp might help there :-))

Yeah, it's the holy grail of compiler architecture.  "Do what I want,
not what I say" :-)


Segher
