Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CD058DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 18:38:17 +1100 (EST)
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302A1BC91@az33exm25.fsl.freescale.net>
References: <11713852392294-git-send-email-timur@freescale.com><20070214003119.GF11491@localhost.localdomain><45D29BBA.7090401@freescale.com><20070214052440.GB12609@localhost.localdomain><45D31734.7030808@freescale.com><20070214233348.GH16279@localhost.localdomain>
	<c8fe6c9c19018243871df0fb9ed23a0b@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1BC76@az33exm25.fsl.freescale.net>
	<B8882F02-616E-4E71-BECC-82BDE5D88A4E@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1BC91@az33exm25.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <87521bc5e5a48f417e1f92b5342a5b60@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: purpose of /chosen node (was RE: [PATCH] powerpc: delete boot-cpu
	and chosen nodes from all DTSfiles)
Date: Fri, 16 Feb 2007 08:38:08 +0100
To: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I understand that point, but mixing the types of properties in
> /chosen doesn't buy us anything.  We shouldn't be shackled by
> the 1275 spec,

Sure, you have some special needs, and some ways in which
the flat tree just _is_ different from an OF device tree;
for example, you don't have instances and ihandles.

Still it doesn't help anyone (and will in fact hurt
everyone) if people start to introduce random incompatibilities
for no good reason at all.

> but having nodes like /chosen with designated
> purpose architecturally make sense.

Yes.  And since this node already has a well-defined
purpose in OF, you better use it for that purpose only
and make a /flattree/grabbag node for your random stuff.

> /chosen shouldn't be a catch-all or a convenient place to stick
> stuff.  I think in this case following 1275 is a good thing.


Segher
