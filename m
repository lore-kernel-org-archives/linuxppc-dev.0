Message-ID: <3CDAB8FC.D833842C@esteem.com>
Date: Thu, 09 May 2002 10:59:24 -0700
From: Conn Clark <clark@esteem.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Performance on PPC8xx using string and multiple load instructions?
 (finalized)
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

        Does anyone know how using the -mstring and -mmultiple GCC
code optimization switches affect performance on the PPC8xx ? The
book I have on PPC assembly says the use of the string and
load-multiple instrutions may be signifigantly slower than the
multiple instruction equivalent on some processors. It does not tell
me which processors or why. I think it might be due to ther fact
that multiple instructions can be paired in multi instruction
pipelined chips. Since the 8xx has only a sigle pipeline I was
wondering if this was the case.

        In the kernel source they use the -mmultiple and -mstring
switches in the PPC architecture dependant code. This may have been
done to reduce code size or it was done with the impression that it
would make things faster as I first thought before looking into it.
I also discovered (according to GCC documentation) that these
instructions don't work on most processors in Little-Endian Mode
(not that it gets used much). If these instructions are
signifigantly slower on some processors and won't work on most in
Little-Endian Mode is this a good idea to have them as default
optimizations for all processors?

        Unfortunatly I only have access to our proprietary MPC850
board and have little experience in benchmarking. If anybody ever
benchmarked code with and with out these instructions on an 8xx
processor or other processor I would like to see the results.

Thanks in advance

        Conn


--

*****************************************************************
  If you live at home long enough, your parents will move out.
*****************************************************************

Conn Clark
Engineering Stooge				clark@esteem.com
Electronic Systems Technology Inc.		www.esteem.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
