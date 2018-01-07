Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zF43L6Ls1zF0RJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Jan 2018 03:43:26 +1100 (AEDT)
Date: Sun, 7 Jan 2018 10:43:04 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: christophe leroy <christophe.leroy@c-s.fr>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Scott Wood <scottwood@freescale.com>,
 Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: Time to get rid of CPU6 ERRATA on powerpc/8xx ?
Message-ID: <20180107164304.GA21977@gate.crashing.org>
References: <26b73379-141c-a705-a552-6ee2b94f4961@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <26b73379-141c-a705-a552-6ee2b94f4961@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jan 07, 2018 at 05:23:13PM +0100, christophe leroy wrote:
> Today, Linux kernel includes a workaround for CPU6 ERRATA on the 8xx
> powerpc.
> 
> This ERRATA exists on the 801, the 823, the 855/860 before revision C.0
> It doesn't concern any modern versions of the 8xx, neither the 860 past
> and including rev C.0, nor the 866 nor the 885
> 
> This workaround complicates the TLBmiss and TLBerror handlers and make
> the code more and more unreadable.
> 
> Since this workaround addresses very old versions of the 8xx, I'd like
> to get rid of it. Do you see any good reason to keep it today ? If not I
> will come with a cleanup patch in the coming weeks.

What is "very old"?  It'll help if you give some indication.

Removing the workarounds is fine by me, of course...  Maybe make it fail
to boot though, with an error message?  Someone *will* try to run it on
an old system, *especially* if you think no one would.

Thanks,


Segher
