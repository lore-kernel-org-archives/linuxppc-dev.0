Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8104BB6F04
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  9 Jul 2010 11:30:20 +1000 (EST)
Subject: Re: [1/2] powerpc/crashdump: Fix issues with kexec and 36bit
	physical addr
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <F4BDFB0D-51C0-49C1-918F-FAC0DD565E63@freescale.com>
References: <1278535881-6463-1-git-send-email-msm@freescale.com>
	<20100708-mitltonm-msm-reply@mdm.bga.com>
	<1278586190.28659.94.camel@pasglop>
	<F4BDFB0D-51C0-49C1-918F-FAC0DD565E63@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 09 Jul 2010 11:30:07 +1000
Message-ID: <1278639007.28659.129.camel@pasglop>
Mime-Version: 1.0
Cc: Matthew McClintock <msm@freescale.com>, linuxppc-dev@lists.ozlabs.org,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-07-08 at 07:40 -0500, Kumar Gala wrote:
> On Jul 8, 2010, at 5:49 AM, Benjamin Herrenschmidt wrote:
> 
> > On Thu, 2010-07-08 at 04:07 -0500, Milton Miller wrote:
> >> On Wed, 07 Jul 2010 around 10:51:20 -0000 Matthew McClintock wrote:
> >>> 
> >>> Fix sizes of variables so correct values are exported via /proc.
> >>> Cast variable in comparison to avoid compiler error.
> >>> 
> > 
> > I'm afraid I already pulled that in. Please send a fixup patch.
> > 

> pulled into which tree?

My confusion. It was in my to-be-posted -next but I hadn't actually
uploaded it yet so I've dropped the patch for now. Matthew, don't send
an incremental fixup, a whole new patch will do. I've also dropped the
second patch that enables building of crash dump kernels for now.

I've left the MPIC CPU reset one though.

Cheers,
Ben.
