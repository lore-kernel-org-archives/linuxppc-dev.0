Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 24111DDF91
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 09:49:03 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m55Nn00f014802
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jun 2008 19:49:00 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m55Nn0f9193602
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jun 2008 19:49:00 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m55NmxZd020519
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jun 2008 19:49:00 -0400
Date: Thu, 5 Jun 2008 18:48:36 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
Message-ID: <20080605184836.5280e8f4@zod.rchland.ibm.com>
In-Reply-To: <20080605173716.3fd28837@wally.pikatech.com>
References: <200806041706.21557.sr@denx.de>
	<20080604220555.658ab13e@vader.jdub.homelinux.org>
	<20080604231641.786bb2dd@lappy.seanm.ca>
	<200806050822.00797.sr@denx.de>
	<20080605173716.3fd28837@wally.pikatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org, Jean
	Delvare <khali@linux-fr.org>, Stefan Roese <sr@denx.de>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 5 Jun 2008 17:37:16 -0400
Sean MacLennan <smaclennan@pikatech.com> wrote:

> On Thu, 5 Jun 2008 08:22:00 +0200
> "Stefan Roese" <sr@denx.de> wrote:
> 
> > So what should we do now? Currently I2C doesn't work at all on 4xx
> > since the driver expects the "index" property and no dts sets this
> > property. Personally I would like to move to using cell-index here,
> > since this seems to be more common. But I could also life with
> > removing the index property and using the "static index" if this is
> > preferred and/or acceptable.
> 
> The warp DTS does ;)

I can't possibly see how.  It lacks the "index" property.

josh
> 
> Cheers,
>    Sean
