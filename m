Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 79C76DDEDD
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Oct 2008 07:11:12 +1000 (EST)
Message-Id: <7E5B6DFB-F9DE-4929-8A4F-8011BF817017@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Adam Litke <agl@us.ibm.com>
In-Reply-To: <1222789675.13978.14.camel@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] properly reserve in bootmem the lmb reserved regions that
	cross numa nodes
Date: Wed, 1 Oct 2008 16:02:33 -0500
References: <48E23D6C.4030406@linux.vnet.ibm.com>
	<1222789675.13978.14.camel@localhost.localdomain>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Jon Tollefson <kniht@linux.vnet.ibm.com>,
	Adam Litke <agl@linux.vnet.ibm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Memory Management List <linux-mm@kvack.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Out of interest how to do you guys represent NUMA regions of memory in  
the device tree?

- k
