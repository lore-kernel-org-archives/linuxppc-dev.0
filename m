Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net
	[151.189.21.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C4F0FDDD07
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 18:34:13 +1100 (EST)
In-Reply-To: <B8882F02-616E-4E71-BECC-82BDE5D88A4E@kernel.crashing.org>
References: <11713852392294-git-send-email-timur@freescale.com><20070214003119.GF11491@localhost.localdomain><45D29BBA.7090401@freescale.com><20070214052440.GB12609@localhost.localdomain><45D31734.7030808@freescale.com><20070214233348.GH16279@localhost.localdomain>
	<c8fe6c9c19018243871df0fb9ed23a0b@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1BC76@az33exm25.fsl.freescale.net>
	<B8882F02-616E-4E71-BECC-82BDE5D88A4E@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <bebb442c0e208ccf7a14392564102507@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: purpose of /chosen node (was RE: [PATCH] powerpc: delete boot-cpu
	and chosen nodes from all DTSfiles)
Date: Fri, 16 Feb 2007 08:34:03 +0100
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I want to reiterate something Paul mentioned, any similarity that the 
> device tree has to 1275 is strictly coincidental.

I'm sure you know it is not coincidental.

Now you can of course do things in a different way if
you really feel the need to, but please do it in a
non-overlapping way then.  So, don't reuse /chosen
for something else than what it is meant for in OF,
etc.


Segher
