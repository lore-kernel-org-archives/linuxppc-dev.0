Return-Path: <Glenn.G.Hart@us.westinghouse.com>
Received: from swec9607.wecnq.com (swec9607.wecnq.com [147.72.234.65])
	by ozlabs.org (Postfix) with ESMTP id E8C63DDED4
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Jun 2007 04:05:39 +1000 (EST)
Subject: Re: Virtex 4 Avnet Mini-Module Networking.
To: kashiwagi@co-nss.co.jp,
	linuxppc-embedded@ozlabs.org
Message-ID: <OFE36702AB.DBD94313-ON852572FF.00633C86-852572FF.00637430@ct.wec.com>
From: Glenn.G.Hart@us.westinghouse.com
Date: Tue, 19 Jun 2007 14:06:18 -0400
MIME-Version: 1.0
Content-type: multipart/mixed;
	Boundary="0__=0ABBF86CDFF0BA168f9e8a93df938690918c0ABBF86CDFF0BA16"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0__=0ABBF86CDFF0BA168f9e8a93df938690918c0ABBF86CDFF0BA16
Content-type: text/plain; charset=us-ascii


Yoshio Kashiwagi,

Yes the checksum off loading is turned off.  Should it be turned on?  My
documentation says I need to use DMA mode to use checksum offloading.

Glenn



                                                                                                     
 (Embedded     Yoshio Kashiwagi <kashiwagi@co-nss.co.jp>@ozlabs.org                                  
 image moved   06/19/2007 11:51 AM                                                                   
 to file:                                                                                            
 pic31426.pcx)                                                                                       
                                                                                                     
                                                                                                     


Sent by:
       linuxppc-embedded-bounces+glenn.g.hart=us.westinghouse.com@ozlabs.org


To:    Glenn.G.Hart@us.westinghouse.com, linuxppc-embedded@ozlabs.org
cc:
Subject:    Re: Virtex 4 Avnet Mini-Module Networking.

Security Level:?              Internal


Glenn-san,

The PLB TEMAC driver is supporting checksum off loading (checksum
calculation by hardware).
If the same kernel source is used, isn't the hardware checksum
of PLB TEMAC disabled by the MHS file of Mini-Module?

BEGIN plb_temac
 PARAMETER INSTANCE = plb_temac_0
 PARAMETER HW_VER = 3.00.a
 PARAMETER C_PLB_CLK_PERIOD_PS = 10000
 PARAMETER C_TXFIFO_DEPTH = 131072
 PARAMETER C_RXFIFO_DEPTH = 131072
 PARAMETER C_MAC_FIFO_DEPTH = 64
 PARAMETER C_BASEADDR = 0x80000000
 PARAMETER C_HIGHADDR = 0x8000ffff
 PARAMETER C_INCLUDE_RX_CSUM = 1    <--- H/W checksum enable
 PARAMETER C_INCLUDE_TX_CSUM = 1    <--- H/W checksum enable
 PARAMETER C_RX_DRE_TYPE = 2
 PARAMETER C_TX_DRE_TYPE = 2

Yoshio Kashiwagi - Nissin Systems

> I am having trouble using the network on the Avent Mini-Module.  I had
the
> network working on the ML403 board with Linux 2.6.19.
>
> The kernel comes up fine with the Mini-Module and the network seems to
work
> until I try to use it.  I can configured the ethernet with ifconfig
and can
> even ping another machine on the network.
>
> The problem is with the TCP layer.  It seems almost everytime the
> Mini-Module sends TCP information the checksum is reported an wrong
(via
> ethereal).  The only thing that comes to mind is the ML403 uses a
Marvell
> PHY and the Mini-Module has a Broadcom PHY.  I do not know enough
about
> low-level networking to know where the problem is.  Is the checksum
> generated in the PHY?  Could something be wrong in Linux programming
the
> Broadcom PHY and not the Marvell PHY?  Why is it only the TCP
information
> (the IP information has the correct checksum)?
>
> Thanks for any information you can offer.
>
> Glenn

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded







--0__=0ABBF86CDFF0BA168f9e8a93df938690918c0ABBF86CDFF0BA16
Content-type: application/octet-stream;
	name="pic31426.pcx"
Content-Disposition: attachment; filename="pic31426.pcx"
Content-Transfer-Encoding: base64

CgUBCAAAAABBADEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAABQgABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAA=


--0__=0ABBF86CDFF0BA168f9e8a93df938690918c0ABBF86CDFF0BA16--
