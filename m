Message-ID: <3FB41757.4020105@kegel.com>
Date: Thu, 13 Nov 2003 15:44:23 -0800
From: Dan Kegel <dank@kegel.com>
MIME-Version: 1.0
To: Jon Masters <jonathan@jonmasters.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [Fwd: ppc4xx Ports]
References: <3FB416F9.7080303@jonmasters.org>
In-Reply-To: <3FB416F9.7080303@jonmasters.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jon Masters wrote:
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

We've been using the linuxppc_2_4_devel tree for ppc405.
I would really love to see its fixes merged into the vanilla
tree, but haven't had occasion to do more than whine about it myself.
- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
