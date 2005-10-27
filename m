Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp5.wanadoo.fr (smtp5.wanadoo.fr [193.252.22.26])
	by ozlabs.org (Postfix) with ESMTP id 428DD68594
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Oct 2005 06:40:28 +1000 (EST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0509.wanadoo.fr (SMTP Server) with ESMTP id 8DE4A1C00297
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Oct 2005 22:40:25 +0200 (CEST)
Received: from pegasos (AStrasbourg-251-1-40-23.w82-126.abo.wanadoo.fr
	[82.126.157.23])
	by mwinf0509.wanadoo.fr (SMTP Server) with ESMTP id 65D621C00291
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Oct 2005 22:40:25 +0200 (CEST)
Date: Thu, 27 Oct 2005 22:38:43 +0200
To: "Mark A. Greer" <mgreer@mvista.com>
Message-ID: <20051027203843.GB13787@localhost.localdomain>
References: <ec55b17e0510270617k368b4555gf3f37e07cee3b4e6@mail.gmail.com>
	<20051027181751.GD9628@mag.az.mvista.com>
	<20051027184921.GA11742@localhost.localdomain>
	<20051027200447.GC13847@mag.az.mvista.com>
	<20051027201105.GD13847@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051027201105.GD13847@mag.az.mvista.com>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Board based on MPC7447 and MV64462
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Oct 27, 2005 at 01:11:05PM -0700, Mark A. Greer wrote:
> Actually, I guess this is more to hide the bridge from the pci_auto when
> it walks the pci buses.  If the pci resources are already allocated
> correctly (as in pegasos?) it may not confuse the generic pci code.
> Even if it doesn't get confused, its by luck.  The bridge's pci regs
> are NOT pci compliant and, IMHO, its iffy to assume that things woun't
> get messed up.

As said, the pci access rtas functions will stop any access to the non-pci
compliant regs.

Friendly,

Sven Luther
