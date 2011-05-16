Return-Path: <bounces@nabble.com>
Received: from sam.nabble.com (sam.nabble.com [216.139.236.26])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EDE61B6EF3
	for <linuxppc-dev@ozlabs.org>; Mon, 16 May 2011 18:55:58 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by sam.nabble.com with esmtp (Exim 4.69)
	(envelope-from <bounces@nabble.com>) id 1QLtak-0005I1-LN
	for linuxppc-dev@ozlabs.org; Mon, 16 May 2011 01:55:54 -0700
Message-ID: <31627334.post@talk.nabble.com>
Date: Mon, 16 May 2011 01:55:54 -0700 (PDT)
From: Vasanth Ragavendran <ragavendrapec@yahoo.co.in>
To: linuxppc-dev@ozlabs.org
Subject: IPSec L2tpv3 throughput low using Netkey kernel stack
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi all,

My setup is as below I've two MPC8315E board from freescale connected as
below

PC1 ---- mpc board1 --- mpc board 2 ----- PC2.

I've installed openswan 2.6.18 on the mpc boards for encrypting the data
sent over the link between mpc boards using IPSEC. I've l2tpv3 bridge
between the mpc boards so that both PC's can be in the same subnet. Now
using l2tpv3 and Ipsec the thruput is only 14.4Mbps tested using iperf and
in tcp mode. I am using the NETKEY kernel stack during Ipsec configuration,
using a PSK method and AES256-SHA1 cipher. I've complied the AES and SHA
crypto API into the kernel running the mpc boards. the kernel version being
2.6.37.6. And it looks like the hardware accelerator is not getting used or
how do I check if the hardware accelerator is getting used? Why is the thru
put so low? With just the l2tpv3 and no IPSec betn the boards i am able to
get a thruput of 40Mbps with the rest of the settings being the same. I read
somewhere that OCF cannot be used with NETKEY and would the thruput be more
if i use KLIPS? if so how do i patch up the kernel with KLIPS. Also I had
patched up the SEC driver from the freescale website 

http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=MPC8315E&nodeId=018rH3Jk191439&fpsp=1&tab=Design_Tools_Tab

but when the Sec driver is configured as module into the kernel the module
doesn;t get inserted gives segmentation fault and if the Sec driver is
configured as non-module type the kernel doesn't bootsup at all! How do i
solve this situation? I'm desperately in need of some help as i've been
working on it to increase the thruput for a long time. Kindly help. Thanks a
lot in advance.
-- 
View this message in context: http://old.nabble.com/IPSec-L2tpv3-throughput-low-using-Netkey-kernel-stack-tp31627334p31627334.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
