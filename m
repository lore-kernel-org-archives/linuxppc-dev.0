Date: Thu, 13 Nov 2003 16:20:23 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Jon Masters <jonathan@jonmasters.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [Fwd: ppc4xx Ports]
Message-ID: <20031114002023.GA9509@gate.ebshome.net>
References: <3FB416F9.7080303@jonmasters.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3FB416F9.7080303@jonmasters.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Nov 13, 2003 at 11:42:49PM +0000, Jon Masters wrote:
> I am working on a 405D port using a base kernel of originally 2.4.20 and
> now 2.4.21 from kernel.org rather than Montavista etc.
>
> There are several 4xx ports kicking around and each bodges the tlb stuff
> in pgtable.h and elsewhere makes simple fixes to make the stock kernel
> actually work...though there are several different offerings by now.
> Would someone care to share experiences privately about 4xx ports?
>
> Cheers,
>
> Jon.
>
> P.S. The stock 2.4.21 kernel on has a bunch of very trivial bugs (from
> losing a register in the syscall handler to breaking shared ptes) and
> will not compile correctly out of the box so to speak. A lot of people
> seem to be using the Montavista tree as a result. Now rather than
> whining I would also like to help so am asking to make contact with
> whoever co-ordinates merging these trees together etc.
>

I use linuxppc-2.4 based tree in our 40x based products. I haven't
checked the most recent version of this tree though (mine is based on
2.4.21 version + some stuff from more recent one (mostly for 440)).

If you have problems with linuxppc-2.4 on 40x hw, report them here :)

Eugene.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
