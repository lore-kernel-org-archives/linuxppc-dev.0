Date: Sun, 08 Sep 2002 22:52:50 +0200
From: o_y <o_yahav@netvision.net.il>
Subject: Re: MPC860T FEC problem
To: linuxppc-embedded@lists.linuxppc.org
Message-id: <MBBBIOFIICDAPDMKHBDEKEDNCAAA.o_yahav@netvision.net.il>
MIME-version: 1.0
Content-type: text/plain; charset=windows-1255
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Wolfgang Denk
You are right ! i didn't specify importent stuff about my work :
The board i'm working on is MPC860TFADS.
I'm using the 2.2.14 kernel because at the moment it's working just fine( i
have not bump into any bugs so far ) . The kernel is stable ,busybox is
working and
so is the network services .
BCSR's are the Board & Statuse Control Registers of the FADS.
The ppcboot-0.8.3 can work only with one of the tow : the scc_enet or the
fec.
Since the scc_enet is working ( and the fec isn't) , ppcboot dont initialize
the BCSR4 register
that (on the mpc860FADS) controls the fec so if i want to use it i have to
initialize it
during the booting process.
The second thing is that i'm not planing to use ppcboot as boot loader in
the future.
I'm only using ppcboot so i coul'd download the image to the memory .
The actual bootloader is mbxboot with some modifications.
When the fec will work i'll burn the image on the flash memory .

If any one succeded to get the fec device to work on this board with
the 2.2 kernel PLEASE tell me how

Thank you for your help and your attention.
oshri.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
