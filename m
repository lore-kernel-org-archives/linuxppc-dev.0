Message-ID: <3D69826A.6020504@redswitch.com>
Date: Sun, 25 Aug 2002 18:20:42 -0700
From: "Xiaogeng (Shawn) Jin" <xjin@redswitch.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: LXT972 FEC problem on MPC855
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

After running ppcboot on our board successfully (including the fast
ethernet LXT972), we have trouble on enabling FEC on linux kernel. The
problem is that we cannot send any packets through the network after the
kernel is booted. The ethernet looks OK during initialization according
to the printed messages. We are trying to locate the problem but haven't
found yet so far. Any hints on what caused such problem?

My configuration on kernel (linux-2.4.4-08-09 from DENX) is
              860T FEC Ethernet
              Use MDIO for PHY configuration
              Support LXT971 PHY

Thanks.

- Shawn.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
