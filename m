Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id E85A9DDF21
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 22:40:16 +1000 (EST)
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 02 Oct 2007 14:40:15 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Message-ID: <20071002124015.242690@gmx.net>
MIME-Version: 1.0
Subject: Re: Problem with OF interrupt parsing code
To: benh@kernel.crashing.org, segher@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Tue, 02 Oct 2007 08:54:04 +1000
> Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> An: Segher Boessenkool <segher@kernel.crashing.org>
> CC: Gerhard Pircher <gerhard_pircher@gmx.net>, linuxppc-dev@ozlabs.org
> Betreff: Re: Problem with OF interrupt parsing code

> It shoudn't normally happen. The reason it -does- happen in fact is that
> the above node is also missing the #interrupt-cells property, which
> cause the parent-lookup routine to skip it before it gets a chance to
> see that there's an "interrupt-controller" property in there.
> 
> I'm not sure whether linux behaviour is a bug or not since I believe we
> are clearly in undefined-land as an interrupt controller should always
> have a #interrupt-cells property.
I think these properties weren't specified in the OF CHRP ISA PIC device
binding document for the PIC node, thus I may have forgotten about them
(CHRP also defines a parent interrupt controller for the PIC, right?).
But the AmigaOne is not a CHRP platform, so I'll add them to the device
tree and then I will see how it works.

Thanks!

Gerhard
