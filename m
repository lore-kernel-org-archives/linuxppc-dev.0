Message-ID: <3CDAB099.11A0DC74@esteem.com>
Date: Thu, 09 May 2002 10:23:37 -0700
From: Conn Clark <clark@esteem.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Performance on PPC8xx using string and multiple load instructions?
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
switches in the architecture dependant code. This may be done to
reduce codeIf these are
instructions signifigantly slower on some processors is this a good
idea to have them as default optimizations for all processors?

	If anybody ever benchmarked code with these instructions
on an 8xx processor or other processor I would like to see the
results.

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
