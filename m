Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ACDC5DDED9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Mar 2008 13:03:41 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JbRAw-0001ZG-6V
	for linuxppc-embedded@ozlabs.org; Mon, 17 Mar 2008 19:03:38 -0700
Message-ID: <16112213.post@talk.nabble.com>
Date: Mon, 17 Mar 2008 19:03:38 -0700 (PDT)
From: Qin Lin <linkinge@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: RE: XUPV2P board opb_emac cannot work with linux-2.6-xlnx
In-Reply-To: <20080317155805.1FFB6538064@mail141-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <16089631.post@talk.nabble.com>
	<20080317155805.1FFB6538064@mail141-sin.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


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
> It should...  (I use it regularly on the xup board)
> Did you remember to connect the interrupt line in your design?
> 
> Steve
> 
> .....
>> [    1.151038] eth0: Xilinx 10/100 EMAC at 0x40C00000 mapped to
> 0xD0020000, irq=2
> ......
> 

-- 
View this message in context: http://www.nabble.com/XUPV2P-board-opb_emac-cannot-work-with-linux-2.6-xlnx-tp16089631p16112213.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
