Return-Path: <bsingharora@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.233])
	by ozlabs.org (Postfix) with ESMTP id 7935EDDDF8
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 21:46:30 +1100 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so1270413nzh
	for <linuxppc-dev@ozlabs.org>; Tue, 06 Nov 2007 02:46:23 -0800 (PST)
Message-ID: <661de9470711060246s3040f68drf0a6310aeec4e1e8@mail.gmail.com>
Date: Tue, 6 Nov 2007 16:16:21 +0530
From: "Balbir Singh" <balbir@linux.vnet.ibm.com>
Sender: bsingharora@gmail.com
To: "Kamalesh Babulal" <kamalesh@linux.vnet.ibm.com>
Subject: Re: 2.6.24-rc1-git15 Kernel build fails on powerpc - Unrecognized
	opcode: `dssall'
In-Reply-To: <47304343.2010709@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47304343.2010709@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Sam Ravnborg <sam@ravnborg.org>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Nov 6, 2007 4:04 PM, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> wrote:
> Hi,
>
> The build fails on the power6 machine while compiling 2.6.24-rc1-git15 kernel,
> with randconfig,
>
>   CHK     include/linux/compile.h
>   AS      arch/powerpc/kernel/swsusp_32.o
> arch/powerpc/kernel/swsusp_32.S: Assembler messages:
> arch/powerpc/kernel/swsusp_32.S:138: Error: Unrecognized opcode: `dssall'
> make[1]: *** [arch/powerpc/kernel/swsusp_32.o] Error 1
> make: *** [arch/powerpc/kernel] Error 2
>

Looks suspiciously like an altivec issue. Could you compile with make
V=1 and/or do a git bisect and see what broke?

Balbir
