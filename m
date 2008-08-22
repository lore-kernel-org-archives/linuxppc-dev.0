Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id BE3ECDEDBB
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Aug 2008 08:20:05 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KWezB-0006U6-41
	for linuxppc-embedded@ozlabs.org; Fri, 22 Aug 2008 15:20:01 -0700
Message-ID: <19116424.post@talk.nabble.com>
Date: Fri, 22 Aug 2008 15:20:01 -0700 (PDT)
From: Tachwali <ytachwali@signalogic.com>
To: linuxppc-embedded@ozlabs.org
Subject: lspci vs scanpci
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hello folks,

I have a general question regarding lspci and scanpci. Upon porting a kernel
2.6.24 to a ppc platform, the kernel seems to be working fine. However, upon
scaning for PCI devices, we have got reasonable results upon running lspci
however scanpci, we are not getting the same results, and scanpci results
looks not right (such as INT_LINE=0xFF) in the PCI devices detected.

Should I be worried about some hardware problem if lspci is working and
scanpci is not? Any advise?

-- 
View this message in context: http://www.nabble.com/lspci-vs-scanpci-tp19116424p19116424.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
