Date: Wed, 25 Aug 2004 11:02:20 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Andriy Korud <a.korud@vector.com.pl>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Current PPC 2.4 kernel trees?
Message-ID: <20040825110220.C9986@home.com>
References: <80908CC5B2C9DB47AAF8C77892FCB44315F884@lion.vector.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <80908CC5B2C9DB47AAF8C77892FCB44315F884@lion.vector.com.pl>; from a.korud@vector.com.pl on Wed, Aug 25, 2004 at 11:29:56AM +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Aug 25, 2004 at 11:29:56AM +0200, Andriy Korud wrote:
>
> Hi,
> can anybody explain which 2.4 kernel trees (especially for PPC) are actual and how are they related with kernel.org's kernel? (I know about Denx's one, any other available, i.e. MontaVista's?).

http://penguinppc.org/dev/kernel.shtml has a list of 2.4 trees.

linuxppc-2.4 is a direct child of linux-2.4 that has additional
functionality not in that kernel.org tree. It has the latest
4xx and 85xx.

linuxppc_2_4_devel is a previous 2.4 devel tree that still has some
good and bad things in it that might be desired on some platforms.
8xx and 82xx might be better here, IIRC.

> I'm currently running 2.6 from kernel.org (PPChameleon board), but for some reason need to downgrade.

I've heard of this board..isn't it 4xx? Do you have patches for this
against 2.6? It isn't in 2.6 now.

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
