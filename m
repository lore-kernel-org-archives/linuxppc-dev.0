Message-ID: <386C150F.22B1A3D0@huawei.com.cn>
Date: Fri, 31 Dec 1999 10:29:35 +0800
From: dony <dony.he@huawei.com.cn>
MIME-Version: 1.0
To: Raphael Bossek <raphael.bossek@solutions4linux.de>,
        Brendan Simon <bsimon@ctam.com.au>, Dan Malek <dan@netx4.com>,
        linuxppc-embed <linuxppc-embedded@lists.linuxppc.org>
Subject: Please help me...
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
      Now I am trying to embed linux onto our MPC860-based board. I have
some questions which may be solved by you embed-linux gurus....
     What I want to do  is the following:
    1     Initialize the MPC860 CPU , memory, serial port, enet port .
    2    Download  the linux powerpc kernel (which I have cross-compiled
on my X86 box)
           from the TFTP server to RAM on board.
    3    run the kernel.
Now the 1 and 2 step work well, but when I download the kernel to RAM on
board, It just cannot run.Do you know why? How can I programme to make
it run? Since the kernel is a compressed image (zvmlinux), need I make
some codes to decompress it and then run it? if so, how to do it?
 Thank you very much :-))
 Merry christmas & happy year.

dony

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
