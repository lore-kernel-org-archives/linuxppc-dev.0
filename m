Date: Sat, 28 Aug 1999 13:30:41 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Martin Costabel <costabel@wanadoo.fr>
cc: Franz Sirl <Franz.Sirl@munich.netsurf.de>, linuxppc-dev@lists.linuxppc.org,
        Paul.Mackerras@cs.anu.edu.au
Subject: Re: vger-2.3.15 on pmac
In-Reply-To: <37C6CA26.49441879@wanadoo.fr>
Message-ID: <Pine.LNX.4.10.9908281329170.8134-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 27 Aug 1999, Martin Costabel wrote:
> The other kernel panics arrived at the end of the boot process or during
> login. The message was "kernel stack overflow, in swapper task, not
> syncing", many lines of "page fault in interrupt handler, addr=c". The
> kernel addresses given were all init_task_union + offset.

I saw the `page fault in interrupt handler, addr=c' too (first call `addr=0'),
until I found out that strcmp() was passed a NULL pointer in
fs/proc/proc_devtree.c. I have no idea why it didn't happen before.

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
