Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id BCF45DDDEC
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Dec 2008 20:26:25 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1L7nzx-0002DA-MI
	for linuxppc-embedded@ozlabs.org; Wed, 03 Dec 2008 01:26:21 -0800
Message-ID: <20809474.post@talk.nabble.com>
Date: Wed, 3 Dec 2008 01:26:21 -0800 (PST)
From: saadia dhouib <saadia_dhouib@yahoo.fr>
To: linuxppc-embedded@ozlabs.org
Subject: xilinx opb_emac support in denx linux 2.6
In-Reply-To: <20794404.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <20794404.post@talk.nabble.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all, 
I have downloaded the 2.6.7 linux kernel from denx, and I have seen that
there is support for 
xsysace, rs232, but there is no support for ethernet opb_emac driver.
Could someone help me to patch the kernel to ass support for opb_emac ?
(kernels from git.xilinx.com do have support for this driver but I need the
denx kernel to be able
to install xenomai).

Thanks a lot


saadia dhouib wrote:
> 
> Hi,
> I have to install a real time microkernel (xenomai) with a linux 2.6
> kernel on a ppc 405 processor embedded in the xilinx xupv2p platform. 
> Xenomai adeos patch is only applicable to kernels from denx tree. 
> So I have to install a linux 2.6 from the denx tree. My question is: 
> Is there support for xilinx drivers (sysace; opb_emac, rs232 ) in denx
> tree,
> if it's not the case, how can I integrate them.
> 
> Thanks
> 

-- 
View this message in context: http://www.nabble.com/xilinx-drivers-support-in-linux-2.6-from-denx-tree---tp20794404p20809474.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
