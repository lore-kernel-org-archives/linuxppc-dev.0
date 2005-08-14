Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A590767EE4
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 14 Aug 2005 14:25:59 +1000 (EST)
Date: Sat, 13 Aug 2005 21:25:56 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Shawn Jin <shawnxjin@gmail.com>
Message-ID: <20050814042556.GB23952@gate.ebshome.net>
References: <c3d0340b0508121811e7b6fc2@mail.gmail.com>
	<20050812203335.K30033@cox.net>
	<c3d0340b0508132056651e8c97@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c3d0340b0508132056651e8c97@mail.gmail.com>
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: writel(), readl() in <asm-ppc/io.h>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, Aug 13, 2005 at 08:56:50PM -0700, Shawn Jin wrote:
> > read*()/write*() are accessors for PCI and PCI only.  PCI is little
> 
> If read*()/write*() are designed for PCI access only as you claimed,
> that explains why they call in/out_leXX() funcitons.
> 
> The problem is that read*()/write*() are misused in some places, e.g.,
> serial drivers such as serial8250. The serial_in() and serial_out()
> call read*() and write*() respectively. So what's your recommendation
> in such a case?

Why do you think this is a problem? Why do you think they are 
misused? Please explain. 

FYI, there _are_ serial PCI cards.

-- 
Eugene
