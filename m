Message-Id: <3839F122.3BF6FEDF@ict.ac.cn>
Date: Tue, 23 Nov 1999 09:42:58 +0800
From: LiuTao <tliu@ict.ac.cn>
Mime-Version: 1.0
To: linuxppc <linuxppc-dev@lists.linuxppc.org>
Subject: need suggestions
Content-Type: text/plain; charset=gb2312
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi All:

I just completed a board with MPC860, there are 16M SDRAM, 2M Flash,
one ethernet port and two serial ports(SMC) on the board. The board
is running well with vxWorks now.
I want to make a bootloader on the board. With the bootloader, I can
download Linux image through TFTP to SDRAM and run it. I also can 
burn the downloaded image into flash, so next time I can boot Linux
from flash. 
I know that many people did this successfully on various boards. 
Can you give me some suggestions? Can you tell me how to do it?
Thanks!

LiuTao

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
