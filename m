From: "Tom Shaver" <tom_shaver@psilongbeach.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: PPC403 bootup problem
Date: Wed, 23 Feb 2000 13:38:12 -0600
Message-ID: <NCBBJBFMKKFOJFGDOKNBCEFIDFAA.tom_shaver@psilongbeach.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <38B41424.8921DC4@netx4.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am trying to boot my IBM 403 eval board using Grant's 403 kernels. First
question is, I don't know what eval bord it is. It doesn't say "OAK" or
anything like that on it. 2nd, the board came with a 403GA processor, in a
socket, which we have replaced with a 403GCX. The ROM monitor eprom routines
startup fine with the GCX installed, recognizing the processor and speed
correctly. It goes through what looks like a normal startup, does a bootp,
loads the linux kernel via tftp, tries to boot the kernel, and hangs
immediately. Here's the transcript of what happens (from the serial port).
Any input appreciated.

=======================================================================

403GCX 8.2 ROM Monitor (5/12/97)

 ------- System Info --------
 Processor speed = 66 MHz
 Bus speed       = 33 MHz
 Amount of DRAM  = 16 MBytes
 ----------------------------

 --- Device Configuration ---
 Power-On Test Devices:
   000  Enabled   System Memory [RAM]
   001  Enabled   Ethernet [ENET]
   004  Disabled  Serial Port 2 [S2]
 ----------------------------
 Boot Sources:
   001  Enabled   Ethernet [ENET]
                  local=206.185.34.211  remote=206.185.34.5
hwaddr=0004ace30b95

   004  Disabled  Serial Port 2 [S2]
                  local=8.1.1.4  remote=8.1.1.1  hwaddr=ffffffffffff
   005  Disabled  Serial Port 1 [S1]
                  Baud = 115200
 ----------------------------
 Debugger: Disabled
 ----------------------------
Press any key to get configuration menu
Checking system RAM
Bank 4 (DRAM): 04 MB   Addr: 0x00c00000
Bank 5 (DRAM): 04 MB   Addr: 0x00400000
Bank 6 (DRAM): 04 MB   Addr: 0x00800000
Bank 7 (DRAM): 04 MB   Addr: 0x00000000
Installed DRAM: 16 MB
Checking DRAM between 0x80000000 and 0x81000000

  System RAM check complete
Booting from [ENET] Ethernet...
Sending bootp request ...


Loading file "/LINUXPPC.IMG" ...
Sending tftp boot request ...
Transfer Complete ...
Loaded successfully ...
Entry point at 0x200000 ...


================================================================


Tom Shaver
Electrical Engineer
Planning Systems Inc.
21294 Johnson Rd
Long Beach, MS 39560
228-863-0007
228-863-0281 Fax


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
