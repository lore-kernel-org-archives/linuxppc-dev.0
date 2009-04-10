Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DDA43DE248
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Apr 2009 07:52:43 +1000 (EST)
Message-ID: <49DFBF4E.60204@freescale.com>
Date: Fri, 10 Apr 2009 16:51:10 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Quieten arch/powerpc in a allmodconfig build.
References: <2c4bcf8d1d7083ff53ce5b556765e96676a007fb.1239165378.git.tony@bakeyournoodle.com>	<1239167335.10104.26.camel@localhost>	<20090408055126.GG16602@bilbo.ozlabs.org>	<7ED93BB3-FE0E-4102-89FB-78950A533717@kernel.crashing.org>	<20090409224553.GO16602@bilbo.ozlabs.org>	<20090410091149.5068d8e1.sfr@canb.auug.org.au>
	<1AAD5906-66FA-4850-8C62-8C030816E44E@kernel.crashing.org>
	<49DF89F7.2070403@freescale.com>
	<FECC6BB4-0505-4319-BCD5-81E8B1C825B5@kernel.crashing.org>
In-Reply-To: <FECC6BB4-0505-4319-BCD5-81E8B1C825B5@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>> And further, there is no separation of warning classes into 
>> might-be-uninitialized and is-uninitialized-compiler-can-tell-for-sure.
> 
> Indeed.  Please file a bug report.

Done: http://gcc.gnu.org/bugzilla/show_bug.cgi?id=39731

-Scott
