Message-ID: <39EF7A07.5D946387@ctam.com.au>
Date: Fri, 20 Oct 2000 09:47:35 +1100
From: Brendan J Simon <brendan.simon@ctam.com.au>
Reply-To: brendan.simon@ctam.com.au
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: linux-embedded: smallest kernel for 2.4.0-test9
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've ported the 2.4.0-test9 kernel to our MPC8260 board.  I have a 512K
boot flash and am trying to get the kernel to fit in it and then mount
the root file system via NFS.  I currently have the kernel down to 520K
but would like to get it under 448K (512K minus one 64K sector for a
bootloader).  Is this possible ???

Please CC to me as well as the list,
Thanks,
Brendan Simon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
