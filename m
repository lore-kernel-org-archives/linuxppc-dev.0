Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r7NSh32YvzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 May 2016 11:40:20 +1000 (AEST)
Message-ID: <1463362819.5704.8.camel@ellerman.id.au>
Subject: Re: udgb on fsl booke?
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Walker <danielwa@cisco.com>, linuxppc-dev@ozlabs.org,
 "xe-kernel@external.cisco.com"
 <xe-kernel@external.cisco.com>, Kumar Gala <galak@kernel.crashing.org>,
 oss@buserror.net
Date: Mon, 16 May 2016 11:40:19 +1000
In-Reply-To: <57367455.5060306@cisco.com>
References: <57367455.5060306@cisco.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-05-13 at 17:41 -0700, Daniel Walker wrote:

> Hi,
> 
> I noticed that udbg is missing for fsl booke , or at least it doesn't 
> appear to be implemented. I don't know a great deal about fsl book. I'm 
> working on an MCP85XX at the moment , and I was looking into the udbg 
> system to get prints. It looks like fsl booke might be similar enough to 
> 44x to use the already implemented udbg routines for that.
> 
> Does anyone have suggestion on this ? Is fsl booke missing because it's 
> not possible to have this, or no one ever needed it ?

Yeah I noticed this recently too.

I don't know the history of why there isn't one, I suspect probably it just was
never merged upstream. Hopefully someone from Freescale can chime in.

On my machine (p5020ds) there is a real UART, so it should just be a matter of
creating a mapping for it and then using the existing udbg_16550 code.

cheers
