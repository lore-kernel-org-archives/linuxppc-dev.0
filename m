Message-ID: <006701be74f2$a3bf8d60$499672cf@sunshinecomputing.com>
From: "Brian Macy" <bmacy@sunshinecomputing.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linuxppc-dev@lists.linuxppc.org>
References: <19990321023338.A2592@persephone.ppc.kernel.org>
Subject: Kernel panic on 2.2.3-ac4 PPC...
Date: Mon, 22 Mar 1999 22:01:46 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Let's see if I can manage to give anything of any use :)
I have a UMAC c500 PPC 603e 240MHz

When I boot the 2.2.3-ac4 kernel I get the following message (I had to write
it down so it isn't the whole message... let me know if there are portions
that are more helpful).

Machine check in kernel mode.
Caused by (from msr): regs c055ddc0 Machine check signal - probably due to
mm fault with mmu off
TASK = c055c000[1] 'swapper' mm->pgd c00dc000 Last syscall:120

Brian Macy


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
