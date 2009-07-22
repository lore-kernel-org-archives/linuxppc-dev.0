Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 65AE0B7079
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jul 2009 01:23:09 +1000 (EST)
Message-Id: <2A0DDADE-5C3C-43F2-9487-98A8A735DC8D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: srikanth krishnakar <skrishnakar@gmail.com>
In-Reply-To: <6213bc560907210233l17aa3e75pcb7c20e3faa24195@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [LTP] msgctl10 fails on Powerpc Linux-2.6.29.6
Date: Wed, 22 Jul 2009 10:22:42 -0500
References: <6213bc560907210233l17aa3e75pcb7c20e3faa24195@mail.gmail.com>
Cc: Linuxppc-dev@ozlabs.org, Ltp-list@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm not seeing any BUG* in traps.c @ line 904.

On Jul 21, 2009, at 4:33 AM, srikanth krishnakar wrote:

> The LTP test case msgctl10.c fails on linux-2.6.29.6 for PowerPC  
> architecture (ppc440)
>
>
> msgctl10    1  B------------[ cut here ]------------
> kernel BUG at arch/powerpc/kernel/traps.c:904!
> Oops: Exception in kernel mode, sig: 5 [#9]

I'm not seeing any BUG* in traps.c @ line 904.  Do you have some other  
patches on top of 2.6.29.6?

- k
