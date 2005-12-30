Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp13.wanadoo.fr (smtp13.wanadoo.fr [193.252.22.54])
	by ozlabs.org (Postfix) with ESMTP id 373CB6892B
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Dec 2005 21:29:05 +1100 (EST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1306.wanadoo.fr (SMTP Server) with ESMTP id B6A2F70000B1
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Dec 2005 11:29:02 +0100 (CET)
Date: Fri, 30 Dec 2005 11:28:16 +0100
To: Sebastian Heutling <sheutlin@gmx.de>
Message-ID: <20051230102816.GB28313@localhost.localdomain>
References: <43B40BFF.1040809@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <43B40BFF.1040809@gmx.de>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: PowerstackII Utah - PCI IRQ for IDE
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 29, 2005 at 05:17:03PM +0100, Sebastian Heutling wrote:
> Hello,
> 
> I wonder what happened to the PCI IRQ map for the PowerstackII Utah - 
> specifically the IDE IRQ. On http://patchwork.ozlabs.org/linuxppc/ I see 
> a patch from Sven Luther with a set IDE IRQ line 
> (http://patchwork.ozlabs.org/linuxppc//patch?id=1082) but on current 
> kernels it doesn't appear. Even on debian the only kernel that had a 
> working kernel with IDE for this machine was 2.6.8 but any following 
> kernel (up to the current 2.6.14) doesn't include any patch for IDE IRQ.

Oh, nobody i know ever tested it, so i guess i didn't notice when it was
removed or something. Can you file a bug report against the debian kernels,
and confirm the IDE line works ? 

BTW, the patch is not from me originally, but from Leigh brown i think.

Friendly,

Sven Luther
