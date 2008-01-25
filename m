Return-Path: <galak@kernel.crashing.org>
Message-Id: <E83C3B2F-0FC4-4248-B718-0C45B56E969A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>, linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Reminder: removal of arch/ppc
Date: Fri, 25 Jan 2008 10:55:25 -0600
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Just a reminder that the plan is to remove arch/ppc this summer (June  
2008).  The following boards still existing over in arch/ppc.  Some of  
them have been ported over to arch/powerpc.  If you care about one of  
these boards and its not ported speak up (it helps if you have access  
to the board).  Also, if you know a given board is free to die of  
bitrot let us know so we know not to worry about it:

	PREP
	PQ2ADS
	TQM8260
	CPCI690
	EV64260
	CHESTNUT
	LOPEC
	KATANA
	HDPU
	MVME5100
	PAL4
	POWERPMC250
	PPLUS
	PRPMC750
	PRPMC800
	RADSTONE_PPC7D
	SANDPOINT
	SBC82xx
	SPRUCE
	LITE5200
	EV64360
	MPC86XADS
	MPC885ADS
	ADS8272

4xx:
	BAMBOO
	CPCI405
	EBONY
	EP405
	BUBINGA
	LUAN
	YUCCA
	OCOTEA
	REDWOOD_5
	REDWOOD_6
	SYCAMORE
	TAISHAN
	WALNUT
	XILINX_ML300
	XILINX_ML403

- k
