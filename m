Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4549AB7BD1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Dec 2009 07:56:50 +1100 (EST)
Subject: Re: [RFC PATCH v2 09/11] powerpc: gamecube/wii: flipper interrupt
	controller support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Herranz <albert_herranz@yahoo.es>
In-Reply-To: <4B15731E.3000109@yahoo.es>
References: <1259441037-15725-1-git-send-email-albert_herranz@yahoo.es>
	<1259441037-15725-10-git-send-email-albert_herranz@yahoo.es>
	<A6D0F7F3-74DB-42BE-BC1D-4C251A75CB16@kernel.crashing.org>
	<4B15731E.3000109@yahoo.es>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 03 Dec 2009 07:56:41 +1100
Message-ID: <1259787401.2076.1159.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-12-01 at 20:48 +0100, Albert Herranz wrote:
> 
> This -1 should be NO_IRQ too.
> I'll fix this in the next version.

No. The number you pass here is not a linux virq number, but a number in
your HW numbering space that never represents a valid IRQ. In your case
0 (NO_IRQ is deprecated anyways) is a valid HW interrupt number. However
-1 sounds good.

So your existing code is fine.

Cheers,
Ben.
