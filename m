Message-Id: <5.1.1.5.2.20021024095541.03009610@mail.lauterbach.com>
Date: Thu, 24 Oct 2002 10:01:21 +0200
To: Ed Swarthout <Ed.Swarthout@motorola.com>
From: Franz Sirl <Franz.Sirl-ppc@lauterbach.com>
Subject: Re: syscall register clobber list
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200210232224.g9NMO5n04849@postal.somerset.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 00:24 24.10.2002, Ed Swarthout wrote:

>asm-ppc/unistd.h is sloppy with the register clobber list for some of
>the _syscallX macros.  gcc with this fix:
>
>    http://gcc.gnu.org/ml/gcc/2002-09/msg00741.html
>
>will issue a bunch of error messages like this:
>
>   include/asm/unistd.h:439: error:
>   asm-specifier for variable `__sc_4' conflicts with asm clobber list

I'm currently testing a more comprehensive patch, which I will submit soon
(see the stuff in current glibc cvs to get a glimpse).

Out of interest, what are you building that needs these macros?

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
