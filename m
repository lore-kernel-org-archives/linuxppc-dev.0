Return-Path: <msm@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) by ozlabs.org (Postfix) with ESMTP id 7D7A41007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Jul 2010 16:33:08 +1000 (EST)
Subject: Re: [PATCH V4] powerpc/prom: Export device tree physical address
	via proc
From: Matthew McClintock <msm@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <FFCEA7A1-6F2B-402F-A698-C882D0B4EB2E@kernel.crashing.org>
References: <1279120733-13584-1-git-send-email-msm@freescale.com>
	<C26140FB-4F77-4D8E-B6C4-63BC9C9EDD83@kernel.crashing.org>
	<1279122163.13098.2.camel@localhost>
	<FFCEA7A1-6F2B-402F-A698-C882D0B4EB2E@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 15 Jul 2010 01:17:22 -0500
Message-ID: <1279174642.28344.6.camel@localhost>
MIME-Version: 1.0
Cc: Kumar Gala <kumar.gala@freescale.com>, linuxppc-dev@lists.ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-07-14 at 17:46 +0200, Segher Boessenkool wrote:
> > What about just one node called "flat-device-tree"?
> 
> But *what* flat device tree?  It cannot be "the" flat device tree,
> or it would be useless information, since we are already reading it! 

I thought about it all day and did not come up with anything terribly
insightful...

"boot-fdt-phys-addr" 
"fdt-phys-addr"
"boot-fdt-phys-reg"
"fdt-phys-addr-reg"

Thoughts?

-M
