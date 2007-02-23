Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E6CA4DDF15
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Feb 2007 04:00:11 +1100 (EST)
In-Reply-To: <9A50C65C-7E90-4F3C-B49B-EE2BCE83168D@kernel.crashing.org>
References: <b16b3a03ce9b890909b3f64f50e78b75@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A592C7@az33exm25.fsl.freescale.net>
	<20070222225707.GB15387@localhost.localdomain>
	<621751322ddfe998a15538e8d3903b93@kernel.crashing.org>
	<20070223003317.GA18508@localhost.localdomain>
	<1be2170fcb25fdc4ac52c93444269737@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A59633@az33exm25.fsl.freescale.net>
	<9A50C65C-7E90-4F3C-B49B-EE2BCE83168D@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e2a80993913e9d3d59be88012ebb6909@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: document new interrupt-array property
Date: Fri, 23 Feb 2007 18:00:01 +0100
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> But how often are developers going to have to tweak these things?  SoC 
> interrupts tend to be fixed so its just a question of external 
> interrupts (and controllers) that a customer has to describe in their 
> dts.

Yes.  So if we want to add some new representation for
interrupt mapping, it would be good if those users
could benefit.  Then again, I don't see any evidence
that "external users" ever need to do any (complicated)
interrupt mapping stuff.


Segher
