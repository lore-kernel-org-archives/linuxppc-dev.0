Message-ID: <20040606180042.47373.qmail@web50501.mail.yahoo.com>
Date: Sun, 6 Jun 2004 11:00:42 -0700 (PDT)
From: Adisorn Ermongkonchai <aermongk@yahoo.com>
Subject: Poor 8260 FCC Ethernet performance 
To: acurtis@onz.com
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Allen and Linuxppc-embedded guru,

Referring to your 31 May 2002 post to LinuxPPC about
poor 8260 FCC Ether performance.  Did you figure
out why is the FCC so slow?  We have encountered this
problem as well. We use the newer MPC8270 with 400MHz
clock and 200MHz CPM speed with BCM5222 PHY.  It
ended up running at only ~5Mbps on 100Mbps Ethernet
line.  We just tried 1 FCC.

Does anyone on this post see the same problem? We use
linux 2.4.18 with PPC pqii driver (somehow the other
driver didn't seem to work for all 3 FCC's)  We
also tried on Motorola 8260 eval board and the result
is the same.  We also tried MEN Micro F6, it gave
better result from 11MBps to 30Mbps.  We also tried
just uboot to eliminate Linux out of the picture and
the result was about the same.

I was about to give up on this MPC8270 then I saw this
post so I thought I try.  I cannot believe that
Motorola would make a chip that support 3 FCC's
but can only run at this ridiculous speed.  I am
software engineer, this could be hardware.

Can anyone help me on this?  I'm about to have to
change the processor to PowerPC 4xx.

Thanks in advance.

Regards,
Adisorn Ermongkonchai


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
