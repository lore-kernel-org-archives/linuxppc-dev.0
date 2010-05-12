Return-Path: <lists@nerdbynature.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 5759CB7DD8
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 May 2010 16:56:56 +1000 (EST)
Date: Tue, 11 May 2010 23:56:51 -0700 (PDT)
From: Christian Kujau <lists@nerdbynature.de>
To: Maxim Uvarov <muvarov@gmail.com>
Subject: Re: [PATCH 1/2] Fix kexec on powerpc32
In-Reply-To: <AANLkTimSATEKI4TdO6zNWSRzl2on4OL5D2GGBlVsndMs@mail.gmail.com>
Message-ID: <alpine.DEB.2.01.1005112351200.3067@bogon.housecafe.de>
References: <20100511174749.19309.44615.stgit@muvarov>
	<4BEA2375.7040802@nerdbynature.de>
	<AANLkTimSATEKI4TdO6zNWSRzl2on4OL5D2GGBlVsndMs@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 12 May 2010 at 10:31, Maxim Uvarov wrote:
> Yes, that is expected result for old tool chains. New tool chains (from code
> sourcery )  need this crt.S.
> I think we can have --with-oldtoolchain option to configure to point to old
> tool chains. (or even rename it to --with-crts,
> I don't know what is better.)

Yes, I've seen this --with-oldtoolchain flag in ./configure, but: when 
exactly is my toolchain old enough so that this flag has to be used? Is my 
binutils 2.18 too old?

So, I'm all in favour of --with-crts (which I would use when compilation breaks
with some descriptive error message) or, even better: can't we set this 
flag during ./configure automatically, based on the actual toolchain installed
on the system? ./configure should be able to determine this, no?

> This -Werror came from mips. kexec/arch/mips/Makefile. It is already removed
> in the git. We already saw this problem.

Powerpc including a mops Makefile, whooha :-)

Thanks,
Christian.
-- 
BOFH excuse #91:

Mouse chewed through power cable
