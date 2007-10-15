Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CFD99DE200
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 04:00:36 +1000 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id l9FHxlGY021365
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 12:59:56 -0500
Mime-Version: 1.0 (Apple Message framework v752.2)
Message-Id: <9F7A6CA7-FA22-4A6D-8538-43A5D3AD7104@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: my git tree rebased
Date: Mon, 15 Oct 2007 13:00:29 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For anyone using my git tree I've rebased it now that the merge  
window for 2.6.24 is ongoing and removed all branches.

The master/HEAD now is in sync with Linus's tree.  I'll be starting  
of a fixes-2.6.24 branch at some point as well as for-2.6.25 branch.

I'll try to keep the master branch as a merge of the various patches  
that exist in the other branches.  Please use the master to create  
any patches against.

- k
