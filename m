Date: Fri, 11 Jul 2003 00:27:27 -0700
From: Peter Ryser <Peter.Ryser@xilinx.com>
Subject: Re: Linux on the Virtex II Pro?
To: "Kerl, John" <John.Kerl@avnet.com>
Cc: "'Charles Lockhart'" <lockhart@jeans.ifa.hawaii.edu>,
	linuxppc-embedded@lists.linuxppc.org
Message-id: <3F0E66DF.2BD1A6CA@xilinx.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <C7FFFEA58B43D311920D0004ACE5333F0F53583A@amer25.avnet.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Current Linux/PPC trees already
> include support for 405 as well as the Xilinx ML300 board.
> (The Linux/PPC tree I got had slightly stale libgen'ed
> code, which I simply replaced with current libgen'ed code
> from my XPS project.)  I can send you a patch file on request.

At the beginning of July the linuxppc_2_4_devel tree has been updated with the
drivers shipping with EDK 3.2 SP2. Further, all necessary changes have been
pushed to move from V2PDK to EDK (interrupt controller bit ordering, System ACE
byte/word addressing, etc.).

Unfortunately, the on-going changes to the OCP implementation (not Virtex-II
Pro related) break the kernel compilation for ML300.

- Peter


----
http://www.xilinx.com/ml300
http://www.xilinx.com/edk


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
