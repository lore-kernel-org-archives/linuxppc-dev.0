Message-ID: <3E57B566.7080800@mvista.com>
Date: Sat, 22 Feb 2003 11:37:42 -0600
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Roland Dreier <roland@digitalvampire.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PowerPC 440GP-specific optimization with gcc
References: <87ptplyot4.fsf@love-shack.home.digitalvampire.org>
In-Reply-To: <87ptplyot4.fsf@love-shack.home.digitalvampire.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Roland Dreier wrote:
> We have a PowerPC 440GP-based design running Linux.  Right now our
> kernel and applications are built with gcc for a "405" target
> (essentially by using the -m405 flag).
>
> This works fine, and all of our executables run with no problem.
> However, we are interested in optimizing specifically for the 440.  As
> far as I can tell, neither gcc 2.95 nor gcc 3.2.2 have any support for
> this.
>
> Is anyone aware of any work in this direction?

I am not a tools expert by any means.. but from my understanding there is work
to support the 440 specific items.

However, I believe the work is focused on enhancing binutils (the assembler) and
not the compiler.  So any 440 specific optimizations you would like would need
to be written in assembly.  (My multi-month old memory is that the 440's new
userspace instructions arn't terribly "generic" to facilitate use in gcc..)

If I'm wrong about any of this someone please correct me!

--Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
