Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 68EC7DDDF2
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 21:24:04 +1100 (EST)
In-Reply-To: <1998FEAC-10FC-4A30-BEA4-82D3430E6299@kernel.crashing.org>
References: <E1HHkAL-0005Xl-2f@jdl.com>
	<2BDA6214-F867-4719-B0F6-E3409FB525F7@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1BB39@az33exm25.fsl.freescale.net>
	<DFBB231C-47A7-46B9-9D56-B651536B2C5A@kernel.crashing.org>
	<20070215221412.GB19126@localhost.localdomain>
	<1998FEAC-10FC-4A30-BEA4-82D3430E6299@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0fefb16d5fe2f45781eae081bdaea79a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [DTC PATCH] Add support for decimal,
	octal and binary based cell values.
Date: Fri, 16 Feb 2007 11:23:53 +0100
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>,
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

> I think we should change dtc to follow standard C conventions and do
> it now rather than later.
>
> We've already introduced dtc version compatibilities issues.  I agree
> with Dan that we should fix this now while there are a small handful
> of .dts in existence and we can provide a compat mode flag that
> treats non-prefixed numbers as hex instead of decimal.
>
> (in theory with that we can use dtc to convert old .dts into new .dts)

May I suggest every DTS file start with a version statement?
That way, you can change its format easily whenever you
want.  This would be version of the source language, not the
same thing as version of the generated blob.


Segher
