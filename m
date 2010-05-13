Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2312FB7E2D
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 14 May 2010 03:29:40 +1000 (EST)
In-Reply-To: <20100512070849.9572.84728.stgit@muvarov>
References: <20100512070841.9572.78661.stgit@muvarov>
	<20100512070849.9572.84728.stgit@muvarov>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <15016EE5-7B40-40C9-9E45-58409644CE17@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2 2/2] powerpc new toolchains fix (crt.S)
Date: Thu, 13 May 2010 19:27:59 +0200
To: Maxim Uvarov <muvarov@gmail.com>
Cc: lists@nerdbynature.de, kexec@lists.infradead.org, horms@verge.net.au,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Linker does not provide some vital functions when building  
> freestanding
> applications with a new toolchain,

That's because the compiler provides those functions, not the linker.

> so we have to provide our own CRT.

...in libgcc.  Why don't you link against that?

> p.s.
> Without the CRT we won't see any build errors (since the purgatory is
> linked with --no-undefined), but the purgatory code won't work,

It would be nice if the build would check if anything unexpectedly
undefined is left.


Segher
