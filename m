Message-Id: <199904202114.RAA69332@kitch12.watson.ibm.com>
To: Gabriel Paubert <paubert@iram.es>
cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Current egcs, binutils and kernel (fwd) 
In-Reply-To: Message from Gabriel Paubert <paubert@iram.es>
   of "Tue, 20 Apr 1999 22:43:24 +0200." <Pine.HPP.3.96.990420223651.20020P-100000@gra-ux1.iram.es>
Date: Tue, 20 Apr 1999 17:14:12 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Gabriel Paubert writes:

David> The original POWER architecture with the MQ register allowed a
David> short sequence to provide this 64-bit functionality.  The PowerPC
David> instruction set does not provide the necessary building blocks, so GCC
David> falls back to the C implementation in libgcc2.c producing the assembly
David> code shown in the later posting.

Gabriel> Yes, but the kernel is not linked with libgcc2. Anyway I've posted a patch
Gabriel> to correctly implement this. And then I've noticed just after that people
Gabriel> do more work than necessary in the cvt_df and cvt_fd routines: floating
Gabriel> point loads and stores never affect or depend on the FPSCR contents, so
Gabriel> there is no point at all in manipulating it (except adding bloat for the
Gabriel> sake of adding bloat).

	The purpose of my earlier message was to explain what was
occurring in rs6000.md and why GCC was calling the function instead of
inlining the code.  I thought that some people might actually want to
understand *WHY* the function was required and why GCC was behaving as
designed. 

David

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
