Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net
	[151.189.21.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B9207DDEDF
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 20:25:32 +1000 (EST)
In-Reply-To: <1181815870.14818.401.camel@localhost.localdomain>
References: <20070612181825.730300780@am.sony.com> >
	<466EEC01.6080807@am.sony.com>
	<f7c4ca74d3e2031e01264f31f09e515a@kernel.crashing.org>
	<20070613084023.GA28629@aepfle.de>
	<0502b4de346bce374f98c49a99be50c1@kernel.crashing.org>
	<1181774580.14818.337.camel@localhost.localdomain>
	<3fa8fff1a1c5b1b353aab4f1ef014804@kernel.crashing.org>
	<1181815870.14818.401.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b7282fe60cb00a9ba8756e152d277fc3@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 29/30] PS3: Device tree source.
Date: Thu, 14 Jun 2007 12:25:21 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Please review the OF spec, sections 3.4 and the "/" entry
>> of 3.5.
>>
>> I'f the flat device tree doc and/or code says differently
>> here, that is a bug.
>
> Well, I wonder if that's been superceeded by some RFC or never 
> validated
> addition ...

It has been that way since before the OF standard
existed, and never has been changed.

> None of the Apple trees for example has a /name property

Apple's trees have many many problems, you know that
as well as anybody.

> and the idea of having a node with a name that doesn't participate in
> the path resolution in just wrong.

Nonsense, a pathname starting with "/" is handled
specially.  This is true on Unix systems as well.

> We should check but I don't think IBM
> trees have one either.
>
> So I stand by the way I defined the flat DT -> no name in the root. But
> you are welcome to use compatible

You can use "compatible" as an alternate name, sure.
Not allowing a "name" in the root node is simply an
oversight in the flat device tree, and should be fixed
in my opinion.  There is no backwwards-compatibility
problem with that.

> and model.

> "model" is a completely separate thing, so yeah.


Segher
