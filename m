Message-ID: <20000529234501.A10933@lx.c-side.com>
Date: Mon, 29 May 2000 23:45:01 -0700
From: Neil Russell <caret@c-side.com>
To: zzh <david-1z@263.net>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Floating point in 8260
References: <39333333.13669@mta5>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <39333333.13669@mta5>; from zzh on Tue, May 30, 2000 at 11:19:15AM +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


As I understand it, there is no production 8260 without an FPU.  Current
production chips are rev A.1 which have an FPU, and new production are rev B
which will also have an FPU.  You probably have no choice for production, so
you should upgrade your test board if it has old an CPU.


Neil.



On Tue, May 30, 2000 at 11:19:15AM +0800, zzh wrote:
>
> I make a port to motorola 8260 ads based on 2.2 kernel.
> Now i am sure the kernel is fuctional,because i can run a
> simple program that fork process and write to stdout.
> I use simple assembly to make system call and does not
> use any c lib.
> When i try to run bash,8260 loops inside FPunavailble
> exception.The 2.2 kernel support 603 with a FP,but
> how should i do with 603e.
> >From this lists,i learned that someone else encounter
> similar problem,they upgrade to a 8260 with FP.
> I do not want to upgrade,how should i do?
> Should i recompile the bash and c lib.How should i treat
> float point.BTW,i have a apple G3,should i compile
> these stuff on this machine?

--
Neil Russell <caret@c-side.com>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
