Message-Id: <20010705072447.Postino-011981@smtp01.highway.ne.jp>
Date: Thu, 5 Jul 2001 07:24:47 +0900
To: David Edelsohn <dje@watson.ibm.com>, Jean-Jacques.Levy@inria.fr,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Re: __divdi3 unresolved + X pointer blocks
In-Reply-To: <200107042222.SAA21410@makai.watson.ibm.com>
References: <Jean-Jacques.Levy@inria.fr>
 <200107042222.SAA21410@makai.watson.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


From: David Edelsohn <dje@watson.ibm.com>
To: Jean-Jacques.Levy@inria.fr
Subject: Re: __divdi3 unresolved + X pointer blocks
Date: Wed, 04 Jul 2001 18:22:45 -0400
cc: k_fukui@highway.ne.jp, linuxppc-dev@lists.linuxppc.org

> >>>>> Jean-Jacques Levy writes:
>
> Jean-Jacques> I installed gcc-3.0 release, and remained with my undefined
> Jean-Jacques> __divdi3. Then I patched inode.c in fs/fat and replaced two
divisions
> Jean-Jacques> by 512 by >> 9. The error disapeared.
>
> Jean-Jacques> Either gcc-3.0 has a bug, either there is a missing module
to
> Jean-Jacques> implement long divisions (by 512!) in fs/fat.o
>
> 	It might be that GCC is not optimizing this division as strongly
> as it should.  __divdi3 is a 64-bit signed divide.  A signed divide is not
> the same as a shift.  Maybe the 64-bit variable is not declared as
> unsigned when it should be?
>
> 	The Linux kernel does not link against libgcc.a, so any GCC
> support routines (such as __divdi3) need to be provided explicitly.
>

I could compile kernel-2.4.6 using gcc-3.0.1pre without this problem.
So I will upload kernel-2.4.6 the makelog and gcc-3.0.1, later.
Let you know when I will upload the package done for JJ.
I believe  that gcc-3.0 also be able to compile the kernel with no problem.

Kaoru


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
