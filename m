From: Thomas Capricelli <capricel@enst.fr>
Reply-To: capricel@enst.fr
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel panic on 2.2.3-ac4 PPC...
Date: Tue, 23 Mar 1999 11:35:17 +0100
Content-Type: text/plain
References: <006701be74f2$a3bf8d60$499672cf@sunshinecomputing.com>
MIME-Version: 1.0
Message-Id: <99032311373202.06215@gauss>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>





>When I boot the 2.2.3-ac4 kernel I get the following message (I had to write
>it down so it isn't the whole message... let me know if there are portions
>that are more helpful).
>
>Machine check in kernel mode.
>Caused by (from msr): regs c055ddc0 Machine check signal - probably due to
>mm fault with mmu off
>TASK = c055c000[1] 'swapper' mm->pgd c00dc000 Last syscall:120

I had got this king of message while trying to boot the 2.2.1 last week.
Problems were happening duing "machine check in kernel mode" and were in some
init_* function like "serial" or "rtc". The only thing i've done is removing
them from the main kernel (module or out), and it was fine.

Thomas

--

Thomas Capricelli	<capricel@enst.fr>
http://www.ecoledoc.lip6.fr/~capricel/

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
