Return-Path: <white@from-b.org>
Received: from aphrodite.net-build.de (aphrodite.net-build.de [212.88.135.60])
	by ozlabs.org (Postfix) with ESMTP id 964FF68802
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Dec 2005 07:57:02 +1100 (EST)
Date: Sun, 18 Dec 2005 21:56:34 +0100
From: White <white@from-b.org>
To: linuxppc-embedded@ozlabs.org
Message-ID: <20051218215634.6fce00f0@White64>
In-Reply-To: <5b74ec4d0512180714r178223f6ub60df08a7ef78fc9@mail.gmail.com>
References: <5b74ec4d0512180714r178223f6ub60df08a7ef78fc9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: x86 gdb with ppc8xx gdbserver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Am Sun, 18 Dec 2005 20:44:27 +0530 schrieb Robin Mathew
<robbinmathew@gmail.com> :

> Hi,
> We are trying to setup gdbserver and gdb for target debugging. We were able
> to connect and debug with eldk's ppc8xx/gdb and ppc8xx gdbserver without any
> issues.
> 
> But I am not able to compile gdb in x86 for ppc8xx target. Can you please
> point to some source tree of gdb that can be compiled for x86 platform for
> ppc8xx target? I tried with gdb version 6.4 but it does not take
> --target=ppc8xx option. I think the option that I am using to compile for
> target is not right.
> 
> Any help in this regard is greatly appreciated.
> 
> Thanks,
> Robin
Please Look at the Docu, i get this work some month ago, but it was a
different host,build,target config.... 

i dont know anymore, but perhaps it helps to try to adjust this
settings.

(I can remember some options like "supported archs" or so...)

soory, that I can't provide exact infos, but I hope this helps a little
bit.

Good Luck,
Bye.
