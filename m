Return-Path: <antoine.brunet@wirecom-tech.com>
Received: from smtp2.clm.net4all.ch (smtp2.net4all-dns.com [80.80.228.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8F925DDE17
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Mar 2008 19:45:24 +1100 (EST)
Received: from WOTEBA (LAubervilliers-153-51-19-43.w193-253.abo.wanadoo.fr
	[193.253.178.43])
	by smtp2.clm.net4all.ch (Postfix) with ESMTP id D68F313A30
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Mar 2008 09:45:17 +0100 (CET)
From: "Antoine BRUNET" <antoine.brunet@wirecom-tech.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: RE: Linuxppc-embedded Digest, Vol 43, Issue 31
Date: Thu, 20 Mar 2008 09:43:30 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <mailman.838.1205857983.869.linuxppc-embedded@ozlabs.org>
Message-Id: <20080320084517.D68F313A30@smtp2.clm.net4all.ch>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I respond to the message numero 3, see and of the mail.

Send Linuxppc-embedded mailing list submissions to
	linuxppc-embedded@ozlabs.org

To subscribe or unsubscribe via the World Wide Web, visit
	https://ozlabs.org/mailman/listinfo/linuxppc-embedded
or, via email, send a message with subject or body 'help' to
	linuxppc-embedded-request@ozlabs.org

You can reach the person managing the list at
	linuxppc-embedded-owner@ozlabs.org

When replying, please edit your Subject line so it is more specific than
"Re: Contents of Linuxppc-embedded digest..."


Today's Topics:

   1. RE: XUPV2P board opb_emac cannot work with linux-2.6-xlnx
      (Qin Lin)
   2. RE: XUPV2P board opb_emac cannot work with linux-2.6-xlnx
      (Qin Lin)
   3. RE: XUPV2P board opb_emac cannot work with linux-2.6-xlnx
      (Stephen Neuendorffer)
   4. [PATCH] Add Fixed PHY support for ucc_geth (Joakim Tjernlund)
   5. Re: [PATCH] Add Fixed PHY support for ucc_geth (Vitaly Bordug)


----------------------------------------------------------------------

Message: 1
Date: Mon, 17 Mar 2008 19:03:38 -0700 (PDT)
From: Qin Lin <linkinge@gmail.com>
Subject: RE: XUPV2P board opb_emac cannot work with linux-2.6-xlnx
To: linuxppc-embedded@ozlabs.org
Message-ID: <16112213.post@talk.nabble.com>
Content-Type: text/plain; charset=us-ascii


Hi Steve,

I think the booting message tell me that the interrupt line is connect
OK,isn't it ?
> [    1.151038] eth0: Xilinx 10/100 EMAC at 0x40C00000 mapped to
0xD0020000, irq=2


and if you can tell me what should be care about in  hard design and in
kernel config with net?  


Stephen Neuendorffer wrote:
> 
> 
> It should...  (I use it regularly on the xup board) Did you remember 
> to connect the interrupt line in your design?
> 
> Steve
> 
> .....
>> [    1.151038] eth0: Xilinx 10/100 EMAC at 0x40C00000 mapped to
> 0xD0020000, irq=2
> ......
> 

--
View this message in context:
http://www.nabble.com/XUPV2P-board-opb_emac-cannot-work-with-linux-2.6-xlnx-
tp16089631p16112213.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.



------------------------------

Message: 2
Date: Mon, 17 Mar 2008 19:17:01 -0700 (PDT)
From: Qin Lin <linkinge@gmail.com>
Subject: RE: XUPV2P board opb_emac cannot work with linux-2.6-xlnx
To: linuxppc-embedded@ozlabs.org
Message-ID: <16112415.post@talk.nabble.com>
Content-Type: text/plain; charset=us-ascii


HI Steve:

when i design the system ,i chose opb_emac_1.04a ,No DMA, Use interrupt ?
Is it the correct setting for the current driver?

Thanks 



Stephen Neuendorffer wrote:
> 
> 
> It should...  (I use it regularly on the xup board)
> Did you remember to connect the interrupt line in your design?
> 
> Steve
> 
>> -----Original Message-----
>> From: linuxppc-embedded-bounces+stephen=neuendorffer.name@ozlabs.org
> [mailto:linuxppc-embedded-
>> bounces+stephen=neuendorffer.name@ozlabs.org] On Behalf Of Qin Lin
>> Sent: Monday, March 17, 2008 12:36 AM
>> To: linuxppc-embedded@ozlabs.org
>> Subject: XUPV2P board opb_emac cannot work with linux-2.6-xlnx
>> 
>> 
>> HI all,
>> 
>> Is anyone have the opb_emac (no DMA) work with the kernel
> linux-2.6-xlnx
>> from git.xilinx.com.
>> the message seams that it does work ,but the command ping return
> nothing!
>> 
>> Could you kindly suggest me what to do?
>> 
>> ps:
>> the kernel booting message
>> [    0.258674] net_namespace: 64 bytes
>> [    0.269780] NET: Registered protocol family 16
>> [    0.290415] Registering device xilinx_emac:0
>> [    0.381687] NET: Registered protocol family 2
>> [    0.392324] IP route cache hash table entries: 2048 (order: 1, 8192
>> bytes)
>> [    0.399556] TCP established hash table entries: 8192 (order: 4,
> 65536
>> bytes)
>> [    0.403403] TCP bind hash table entries: 8192 (order: 3, 32768
> bytes)
>> [    0.405409] TCP: Hash tables configured (established 8192 bind
> 8192)
>> [    0.405489] TCP reno registered
>> [    0.412758] sysctl table check failed: /kernel/l2cr .1.31 Missing
>> strategy
>> [    0.413189] Call Trace:
>> [    0.413244] [cf41feb0] [c0008178] show_stack+0x48/0x184
> (unreliable)
>> [    0.413467] [cf41fed0] [c00303c8] set_fail+0x50/0x68
>> [    0.413640] [cf41fef0] [c0030b54] sysctl_check_table+0x64c/0x698
>> [    0.413724] [cf41ff20] [c0030b68] sysctl_check_table+0x660/0x698
>> [    0.413802] [cf41ff50] [c001e810] register_sysctl_table+0x64/0xb4
>> [    0.414141] [cf41ff70] [c01e4b1c]
> register_ppc_htab_sysctl+0x18/0x2c
>> [    0.414311] [cf41ff80] [c01de1e4] kernel_init+0xc8/0x284
>> [    0.414384] [cf41fff0] [c0004ab8] kernel_thread+0x44/0x60
>> 
>> [    1.116395] xilinx_emac xilinx_emac.0: MAC address is now  2: 0: 0:
> 0: 0:
>> 0
>> [    1.123790] XEmac: using fifo mode.
>> [    1.128188] XEmac: Detected PHY at address 0, ManufID 0x0013, Rev.
>> 0x78e2.
>> [    1.135715] eth0: Dropping NETIF_F_SG since no checksum feature.
>> [    1.151038] eth0: Xilinx 10/100 EMAC at 0x40C00000 mapped to
> 0xD0020000,
>> irq=2
>> [    1.158713] eth0: XEmac id 1.4a, block id 128, type 1
>> [    1.194661] TCP cubic registered
>> [    1.198647] NET: Registered protocol family 1
>> [    1.203728] NET: Registered protocol family 17
>> 
>> 
>> #ping 192.168.26.1 &
>> # ifconfig eth0
>> eth0      Link encap:Ethernet  HWaddr 02:00:00:00:00:00
>>           inet addr:192.168.26.127  Bcast:192.168.26.255
> Mask:255.255.255.0
>>           UP BROADCAST RUNNING  MTU:1500  Metric:1
>>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>>           TX packets:16 errors:0 dropped:0 overruns:0 carrier:0
>>           collisions:0 txqueuelen:1000
>>           RX bytes:0 (0.0 B)  TX bytes:672 (672.0 B)
>>           Interrupt:2 Memory:40c00000-40c0ffff
>> 
>> Regards
>> 
>> Qin Lin
>> --
>> View this message in context:
> http://www.nabble.com/XUPV2P-board-opb_emac-cannot-work-with-linux-2.6-
>> xlnx-tp16089631p16089631.html
>> Sent from the linuxppc-embedded mailing list archive at Nabble.com.
>> 
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context:
http://www.nabble.com/XUPV2P-board-opb_emac-cannot-work-with-linux-2.6-xlnx-
tp16089631p16112415.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.



------------------------------

Message: 3
Date: Mon, 17 Mar 2008 21:30:23 -0700
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: RE: XUPV2P board opb_emac cannot work with linux-2.6-xlnx
To: "Qin Lin" <linkinge@gmail.com>,	<linuxppc-embedded@ozlabs.org>
Message-ID: <20080318043128.DDDA0ED005E@mail85-dub.bigfish.com>
Content-Type: text/plain; charset="iso-8859-1"


Yes that should work...

Steve

-----Original Message-----
From: linuxppc-embedded-bounces+stephen=neuendorffer.name@ozlabs.org on
behalf of Qin Lin
Sent: Mon 3/17/2008 7:17 PM
To: linuxppc-embedded@ozlabs.org
Subject: RE: XUPV2P board opb_emac cannot work with linux-2.6-xlnx
 

HI Steve:

when i design the system ,i chose opb_emac_1.04a ,No DMA, Use interrupt ?
Is it the correct setting for the current driver?

Thanks

Hi,
I use ml403 board and Edk 9.1 and kernel linux-2.6-xlnx 2.6.24rc8.
My emac runs normally with this kernel 2.6.24rc8.
My emac is dysigned on my bsp project with interruption and reset :
.MHS :
BEGIN opb_ethernet
 PARAMETER INSTANCE = Ethernet_MAC
 PARAMETER HW_VER = 1.04.a
 PARAMETER C_DMA_PRESENT = 1
 PARAMETER C_IPIF_RDFIFO_DEPTH = 32768
 PARAMETER C_IPIF_WRFIFO_DEPTH = 32768
 PARAMETER C_OPB_CLK_PERIOD_PS = 10000
 PARAMETER C_BASEADDR = 0x40c00000
 PARAMETER C_HIGHADDR = 0x40c0ffff
 BUS_INTERFACE SOPB = opb
 PORT IP2INTC_Irpt = Ethernet_MAC_IP2INTC_Irpt
 PORT PHY_tx_data = fpga_0_Ethernet_MAC_PHY_tx_data
 PORT PHY_tx_en = fpga_0_Ethernet_MAC_PHY_tx_en
 PORT PHY_tx_clk = fpga_0_Ethernet_MAC_PHY_tx_clk
 PORT PHY_tx_er = fpga_0_Ethernet_MAC_PHY_tx_er
 PORT PHY_rx_er = fpga_0_Ethernet_MAC_PHY_rx_er
 PORT PHY_rx_clk = fpga_0_Ethernet_MAC_PHY_rx_clk
 PORT PHY_dv = fpga_0_Ethernet_MAC_PHY_dv
 PORT PHY_rx_data = fpga_0_Ethernet_MAC_PHY_rx_data
 PORT PHY_Mii_clk = fpga_0_Ethernet_MAC_PHY_Mii_clk
 PORT PHY_Mii_data = fpga_0_Ethernet_MAC_PHY_Mii_data
 PORT PHY_rst_n = fpga_0_Ethernet_MAC_PHY_rst_n
END

Be carreful the reset pin is mandatory, at first i have ommitedd this IO ans
my emac didn't work.
I have just add this reset IO and emac works properly...
I dont know if the tall of tje fifo are important but i have always done
32768.

I hope i can help you...

Antoine BRUNET
