From: laurent.mohin@acterna.com
To: srossi@labs.mot.com
Cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <C1256B37.002F2511.00@magnus.eni.wago.de>
Date: Fri, 4 Jan 2002 09:31:12 +0100
Subject: Re : IDE DMA on 8xx ??
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steve,

I used the IDMA on an MPC821 to perform IDE transfers (either to floppy or hard
disk drive). At this time, my O.S was pSOS.
You have just to be aware that the IDMA is done via software by the CPM of the
MPC821. So you won't exceed a 2Mbytes/s throughput.

Laurent


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
