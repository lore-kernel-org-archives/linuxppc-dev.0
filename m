From: "Kevin Buettner" <kev@primenet.com>
Message-Id: <990801202455.ZM22552@redrock.lan>
Date: Sun, 1 Aug 1999 20:24:54 +0000
In-Reply-To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
        "Re: gdb broken under linuxppc r5 tools" (Aug  1,  9:03pm)
References: <14244.17697.552036.29509@ipa.ne.mediaone.net>
	<v03110700b3ca439d2553@[209.183.130.185]>
	<99080121250000.02221@ns1102.munich.netsurf.de>
To: "Kevin B. Hendricks" <kbhend@business.wm.edu>,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: gdb broken under linuxppc r5 tools
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Aug 1,  9:03pm, Franz Sirl wrote:

> Am Son, 01 Aug 1999 schrieb Kevin B. Hendricks:
> >Hey,
> >
> >Does anyone know what's up with gdb lately?  It used to be quite stable but
> >since I upgraded to the glibc, binutils, egcs, gdb from Linuxppc R5 cd, I
> >can't seem to set any breakpoints in shared libraries (or they show up
> >someplace else at random).  Functions are missing (or don't show up) and if
> >I try to disassemble one function in a shared library, I often get another.
> >
> >I really need a working stable gdb.
> >
> >Has anyone else run into this.  If so, exactly what versions of gdb, glibc,
> >binutils, egcs are stable together, especially when working with shared
> >libraries?
> 
> Well, you've hit one of our weakest points here. AFAIK there's currently nobody
> taking care of gdb on Linux/PPC. In fact we are lucky that Kevin Buettner's old
> patch could be converted to 4.17.x. Unfortunately it's still not integrated
> into gdb's mainline due to copyright issues, so we have to reintegrate the patch
> in every new version :-(.
> 
> So, is someone willing to take care of gdb on Linux/PPC?

Kevin, Franz, et.al,

Earlier this year, Metrowerks and I signed the copyright assignments
required by the FSF.  Beginning August 9, I will be starting work at
Cygnus as a GDB engineer.  One of the things that I'll work on is a
merge of my patches into the current gdb mainline.  It'll be my goal
to get a solid, usable gdb up and running on Linux/PPC again.

Kevin

-- 
Kevin Buettner
kev@primenet.com

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
