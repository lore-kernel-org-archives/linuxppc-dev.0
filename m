Return-Path: <cbouatmailru@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by ozlabs.org (Postfix) with ESMTP id B7F04B7E23
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 14 May 2010 05:07:50 +1000 (EST)
Received: by wyb29 with SMTP id 29so40453wyb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 May 2010 12:07:47 -0700 (PDT)
Date: Thu, 13 May 2010 23:07:43 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2 2/2] powerpc new toolchains fix (crt.S)
Message-ID: <20100513190743.GA14447@oksana.dev.rtsoft.ru>
References: <20100512070841.9572.78661.stgit@muvarov>
	<20100512070849.9572.84728.stgit@muvarov>
	<15016EE5-7B40-40C9-9E45-58409644CE17@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <15016EE5-7B40-40C9-9E45-58409644CE17@kernel.crashing.org>
Cc: Maxim Uvarov <muvarov@gmail.com>, lists@nerdbynature.de, horms@verge.net.au,
	kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 13, 2010 at 07:27:59PM +0200, Segher Boessenkool wrote:
> >Linker does not provide some vital functions when building
> >freestanding
> >applications with a new toolchain,
> 
> That's because the compiler provides those functions, not the linker.
> 
> >so we have to provide our own CRT.
> 
> ...in libgcc.  Why don't you link against that?

For the same reason we don't link kernel against libgcc?
I.e. just a matter of taste. There are two camps: those who
argue against libgcc, and those who argue for libgcc.

Hey! You were in this thread! :-)

http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg17224.html

Purgatory is just a small (tiny) piece of code that runs
between kernels. Whether use libgcc or not, personally, I have
no strong opinion. Kexec didn't use it, so we kept it the same
way.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
