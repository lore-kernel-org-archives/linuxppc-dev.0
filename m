Return-Path: <agl@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3F6E4DDECD
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 04:47:55 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l78Ilq0V001421
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 14:47:52 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l78Ill9Z157554
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 12:47:48 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l78IlkSs015184
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 12:47:47 -0600
Subject: [Documentation] Page Table Layout diagrams
From: Adam Litke <agl@us.ibm.com>
To: linux-mm <linux-mm@kvack.org>
Content-Type: text/plain
Date: Wed, 08 Aug 2007 13:47:45 -0500
Message-Id: <1186598865.23817.76.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello all.  In an effort to understand how the page tables are laid out
across various architectures I put together some diagrams.  I have
posted them on the linux-mm wiki: http://linux-mm.org/PageTableStructure
and I hope they will be useful to others.  

Just to make sure I am not spreading misinformation, could a few of you
experts take a quick look at the three diagrams I've got finished so far
and point out any errors I have made?  Thanks.

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center
