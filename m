From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
To: "Kevin B. Hendricks" <kbhend@business.wm.edu>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: gdb broken under linuxppc r5 tools
Date: Sun, 1 Aug 1999 21:03:49 +0200
Content-Type: text/plain
References: <14244.17697.552036.29509@ipa.ne.mediaone.net> <v03110700b3ca439d2553@[209.183.130.185]>
In-Reply-To: <v03110700b3ca439d2553@[209.183.130.185]>
MIME-Version: 1.0
Message-Id: <99080121250000.02221@ns1102.munich.netsurf.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Am Son, 01 Aug 1999 schrieb Kevin B. Hendricks:
>Hey,
>
>Does anyone know what's up with gdb lately?  It used to be quite stable but
>since I upgraded to the glibc, binutils, egcs, gdb from Linuxppc R5 cd, I
>can't seem to set any breakpoints in shared libraries (or they show up
>someplace else at random).  Functions are missing (or don't show up) and if
>I try to disassemble one function in a shared library, I often get another.
>
>I really need a working stable gdb.
>
>Has anyone else run into this.  If so, exactly what versions of gdb, glibc,
>binutils, egcs are stable together, especially when working with shared
>libraries?

Well, you've hit one of our weakest points here. AFAIK there's currently nobody
taking care of gdb on Linux/PPC. In fact we are lucky that Kevin Buettner's old
patch could be converted to 4.17.x. Unfortunately it's still not integrated
into gdb's mainline due to copyright issues, so we have to reintegrate the patch
in every new version :-(.

So, is someone willing to take care of gdb on Linux/PPC?

Kevin, as a first measure, do you pass LD_BIND_NOW=1 in the environment?

Franz.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
