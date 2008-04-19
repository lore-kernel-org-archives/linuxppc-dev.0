Return-Path: <galak@kernel.crashing.org>
Message-Id: <D713F373-AE2A-4341-9C29-EF65B9399B36@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: removal of arch/ppc in 2.6.27?
Date: Sat, 19 Apr 2008 10:30:10 -0500
Cc: LinuxPPC-Embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is intended as a reminder that we plan on getting rid of arch/ppc  
this summer.  I'm guessing based on kernel release times that will be  
2.6.27.  That would mean 2.6.26 will be the last kernel to support  
arch/ppc.

If people have boards that like ported over please let us know and  
work with us to port this over to arch/powerpc.

Here is a list based on arch/ppc/platforms.  Its not intended to be  
complete but a general idea of what's left in arch/ppc.

PPC_PREP        e6xx
PQ2ADS          82xx            in arch/powerpc?
TQM8260         82xx
CPCI690         e6xx/mv64x60
EV64260         e6xx/mv64x60
CHESTNUT        e6xx/mv64x60
LOPEC           e6xx
KATANA          e6xx/mv64x60
HDPU            e6xx/mv64x60
MVME5100        e6xx
PAL4            e6xx
POWERPMC250     e6xx
PPLUS           e6xx
PRPMC750        e6xx
PRPMC800        e6xx
RADSTONE_PPC7D  e6xx
SANDPOINT       e6xx
SBC82xx         82xx
SPRUCE          e6xx
LITE5200        52xx
EV64360         e6xx/mv64x60
MPC86XADS       8xx             in arch/powerpc
MPC885ADS       8xx             in arch/powerpc
ADS8272         82xx            in arch/powerpc

4xx:
BAMBOO          44x             in arch/powerpc
CPCI405         40x
EBONY           44x             in arch/powerpc
EP405           40x             in arch/powerpc
BUBINGA         40x
LUAN            44x
YUCCA           44x
OCOTEA          44x
REDWOOD_5       40x
REDWOOD_6       40x
SYCAMORE        40x
TAISHAN         44x             in arch/powerpc
WALNUT          40x             in arch/powerpc
XILINX_ML300    40x
XILINX_ML403    40x

- k
