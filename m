Message-Id: <v03110700b3ca439d2553@[209.183.130.185]>
In-Reply-To: <99080116025601.00416@ns1102.munich.netsurf.de>
References: <14244.17697.552036.29509@ipa.ne.mediaone.net>
 <14244.17697.552036.29509@ipa.ne.mediaone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 1 Aug 1999 14:38:31 -0400
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        linuxppc-dev@lists.linuxppc.org
From: "Kevin B. Hendricks" <kbhend@business.wm.edu>
Subject: gdb broken under linuxppc r5 tools 
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hey,

Does anyone know what's up with gdb lately?  It used to be quite stable but
since I upgraded to the glibc, binutils, egcs, gdb from Linuxppc R5 cd, I
can't seem to set any breakpoints in shared libraries (or they show up
someplace else at random).  Functions are missing (or don't show up) and if
I try to disassemble one function in a shared library, I often get another.

I really need a working stable gdb.

Has anyone else run into this.  If so, exactly what versions of gdb, glibc,
binutils, egcs are stable together, especially when working with shared
libraries?

Thanks,

Kevin




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
