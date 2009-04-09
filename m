Return-Path: <tony@bakeyournoodle.com>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 90798DDFBD
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Apr 2009 08:45:53 +1000 (EST)
Date: Fri, 10 Apr 2009 08:45:53 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Quieten arch/powerpc in a allmodconfig build.
Message-ID: <20090409224553.GO16602@bilbo.ozlabs.org>
References: <2c4bcf8d1d7083ff53ce5b556765e96676a007fb.1239165378.git.tony@bakeyournoodle.com>
	<1239167335.10104.26.camel@localhost>
	<20090408055126.GG16602@bilbo.ozlabs.org>
	<7ED93BB3-FE0E-4102-89FB-78950A533717@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <7ED93BB3-FE0E-4102-89FB-78950A533717@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 10, 2009 at 12:46:06AM +0200, Segher Boessenkool wrote:

> -Wno-unused or -Wno-unused-pparameter and/or -Wno-unused-variable.  But I
> thought this was about uninitialised var warnings?  -Wno-uninitialized
> for that one.

> If you are asking for a GCC option that will warn for all suspect cases
> _except_ for the ones where it is obvious to you there is no problem:
> you could try -Wesp.

Ooops I was asking for -Wno-uninitialized.  I'll try a build with:
	-Wno-uninitialized -Wesp
and see how that goes.

Thanks.

Yours Tony
