Return-Path: <cfriesen@nortel.com>
Received: from zcars04f.nortelnetworks.com (zcars04f.nortelnetworks.com
	[47.129.242.57]) by ozlabs.org (Postfix) with ESMTP id 4485767AB0
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Feb 2005 11:28:06 +1100 (EST)
Message-ID: <41FECA18.50609@nortelnetworks.com>
Date: Mon, 31 Jan 2005 18:15:20 -0600
From: Chris Friesen <cfriesen@nortel.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org,
	Linux kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: question on symbol exports
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It appears that in 2.6.9 the ppc64 version of flush_tlb_page() depends 
on two symbols which are not currently exported: the function 
__flush_tlb_pending(), and the per-cpu variable ppc64_tlb_batch.

Is there any particular reason why modules should not be allowed to 
flush the tlb, or is this an oversight?

Chris
