Return-Path: <rientjes@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [216.239.33.17])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F3321DDD01
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Dec 2007 10:10:26 +1100 (EST)
Date: Fri, 7 Dec 2007 15:10:07 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Balbir Singh <balbir@linux.vnet.ibm.com>
Subject: Re: [PATCH] Fake NUMA emulation for PowerPC
In-Reply-To: <4759C548.6030304@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.0.9999.0712071508460.27689@chino.kir.corp.google.com>
References: <20071207211425.10223.91240.sendpatchset@balbir-laptop>
	<20071207212817.GA391@lixom.net>
	<4759BCA2.1020809@linux.vnet.ibm.com>
	<975B5B2B-C1F3-4021-9AE2-8873FFE1BDEC@kernel.crashing.org>
	<4759C548.6030304@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
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

> To be able to test the memory controller under NUMA, I use fake NUMA
> nodes. x86-64 has a similar feature, the code I have here is the
> simplest I could come up with for PowerPC.
> 

Magnus Damm had patches from over a year ago that, I believe, made much of 
the x86_64 fake NUMA code generic so that it could be extended for 
architectures such as i386.  Perhaps he could resurrect those patches if 
there is wider interest in such a tool.
