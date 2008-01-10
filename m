Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 746A7DE164
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Jan 2008 02:46:08 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Per-Erik Johansson <perka@dtek.chalmers.se>
In-Reply-To: <1526.213.15.68.47.1199872028.squirrel@webmail.chalmers.se>
Subject: Re: Toolchain for Freescale e200
References: <5797.213.15.68.47.1198072613.squirrel@webmail.chalmers.se>
	<67A10FA1-8F9D-4A87-BB67-C04EC9FA5BEF@kernel.crashing.org>
	<1526.213.15.68.47.1199872028.squirrel@webmail.chalmers.se>
Message-Id: <4DA554B1-FBDD-4E5C-AEC3-97EB84020117@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Date: Thu, 10 Jan 2008 09:46:01 -0600
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jan 9, 2008, at 3:47 AM, Per-Erik Johansson wrote:

> Hi
>
> I need a new toolchain since my old one hasn't got support for the  
> (as)
> -me200 and book-e stuff I need to compile a kernel for the e200 core.
> What flags do I specify to get what I need?
> --target=powerpc-e200-linux-gnu --with-cpu=?? --enable-threads=posix
> --enable-languages=c,c++ --with-gnu-as --with-gnu-ld
> And should I use a particular version of gcc, binutils..?
>
> I'm not that familiar with building cross-toolchains, have tried with
> tools like crosstool and buildroot but cant seem to get it to build  
> what I
> need.
>> From what I understand the e200 and e500 are code compatible so  
>> maybe I
> could a toolchain for e500 instead, --with-cpu=8540?
> Any help is much appreciated!

if you aren't using VLE than an e500 toolchain should be sufficient.

- k
