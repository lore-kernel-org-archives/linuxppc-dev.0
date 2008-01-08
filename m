Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BA790DDEEF
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 17:04:42 +1100 (EST)
Message-Id: <86AA8535-E2CF-4891-900B-340049A5CA19@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Sean MacLennan <smaclennan@pikatech.com>
In-Reply-To: <4782DAD8.1080104@pikatech.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: How complete should the DTS be?
Date: Tue, 8 Jan 2008 00:04:36 -0600
References: <4782DAD8.1080104@pikatech.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 7, 2008, at 8:07 PM, Sean MacLennan wrote:

> Just a general question about DTS "completeness". Like all 440EP
> processors, the taco has two i2c buses. However, only one bus has
> anything connected to it.
>
> Should I show both bus entries in the DTS, or only the one that is  
> used?
> I have generally only been showing the devices that are present. i.e.
> Only one emac, only one serial port.
>
> Is there a convention for this?


The .dts should reflect the HW as its used.  On some reference boards  
we might put out more info because of the various configs these types  
of boards can be setup in.  However if something has a static config  
just describe that.  So in your example of two i2c buses with only one  
connected, just describe the one that is used.

- k
