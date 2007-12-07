Return-Path: <rientjes@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [216.239.45.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 46662DDE23
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Dec 2007 10:12:11 +1100 (EST)
Date: Fri, 7 Dec 2007 15:11:18 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Balbir Singh <balbir@linux.vnet.ibm.com>
Subject: Re: [PATCH] Fake NUMA emulation for PowerPC
In-Reply-To: <4759C89B.9000709@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.0.9999.0712071510370.27689@chino.kir.corp.google.com>
References: <20071207211425.10223.91240.sendpatchset@balbir-laptop>
	<20071207221106.GH16824@localdomain>
	<4759C89B.9000709@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 8 Dec 2007, Balbir Singh wrote:

> Yes, they all appear on node 0. We could have tweaks to distribute CPU's
> as well.
> 

You're going to want to distribute the cpu's based on how they match up 
physically with the actual platform that you're running on.  x86_64 does 
this already and it makes fake NUMA more useful because it matches the 
real-life case more often.
