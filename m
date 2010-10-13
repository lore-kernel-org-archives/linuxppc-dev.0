Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3610DB6EE8
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Oct 2010 01:18:02 +1100 (EST)
Subject: Re: [PATCH] powerpc/fsl: 85xx: add cache-sram support
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <AANLkTi=8q-8+ZR=unxZdhQQZsn33hte_VNEvZpE0uGgp@mail.gmail.com>
Date: Wed, 13 Oct 2010 09:17:53 -0500
Message-Id: <7CC89883-0AF0-42F3-B2E0-9DB7C69597C3@kernel.crashing.org>
References: <1286879117-5616-1-git-send-email-harninder.rai@freescale.com>
	<04CFEB4E-DFA2-44AB-AD90-859A7D0691A8@kernel.crashing.org>
	<72F25CD340E3C147B5A186012F8331E7CB6ECF@zin33exm20.fsl.freescale.net>
	<AANLkTi=8q-8+ZR=unxZdhQQZsn33hte_VNEvZpE0uGgp@mail.gmail.com>
To: Hollis Blanchard <hollis@penguinppc.org>
Cc: linuxppc-dev@lists.ozlabs.org, Rai Harninder-B01044 <B01044@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 12, 2010, at 12:19 PM, Hollis Blanchard wrote:

> On Tue, Oct 12, 2010 at 10:02 AM, Rai Harninder-B01044
> <B01044@freescale.com> wrote:
>> Currently the design is that we divide the sram portion into 2 equal
>> parts for AMP
>> That was the part of initial requirement
>> Do we want to remove that?
> 
> Why wouldn't you just pass different cache-sram-size/offset values to
> each kernel?

That was what I was suggesting, but probably wasn't clear :)

- k
