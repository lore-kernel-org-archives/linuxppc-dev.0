Message-ID: <3803583E.526DCD2E@eng.uct.ac.za>
Date: Tue, 12 Oct 1999 17:48:14 +0200
From: Grant Carter <gcarter@eng.uct.ac.za>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Help with BSE-IP Board and Linux 2.2.5
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all

Perhaps someone can help me. I have just received my BSE IP-Engine and
have compiled the 2.2.5 kernel for it. The compilation went successfully
and, after setting up the IP address etc on the board and getting my
TFTP server running, I downloaded the kernel to the board (via Ethernet
so I know it is working). Since the user space starts at 0x4000, I
loaded the zImage there. When I tried to run it, the BSE board froze. I
found that I had downloaded an old kernel from linuxppc.cs.nmt.edu for
the BSE board and when I tried it, I got the same results. Does it
matter to the kernel at what address in memory it is loaded and if so,
where can I change this is the linker?

I have set up my NFS server with the mbxroot.min files in it. I am not
100% sure that this is working but am I correct in assuming that I
should see the beginning of the kernel booting before it requires any
files from the NFS server? 

Any ideas on how to proceed from here? Does somebody have a known
working kernel for this board which I can try?

TIA
Grant

-- 
Grant Carter                              gcarter@eng.uct.ac.za
Department of Electrical Engineering      University of Cape Town
Tel: +27 (0)21 650-3467                   Fax: +27 (0)21 650-3465
                     "Coffee not found - operator halted!"

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
