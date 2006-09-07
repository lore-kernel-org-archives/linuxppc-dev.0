Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.vr.in-berlin.de",
	Issuer "IN-Berlin Server CA (G2)" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 03D8367B72
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Sep 2006 05:35:21 +1000 (EST)
Message-ID: <4500743D.9000403@s5r6.in-berlin.de>
Date: Thu, 07 Sep 2006 21:34:21 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Fwd: Re: ohci1394: steps to implement suspend/resume]
References: <44FEDF5D.9060707@s5r6.in-berlin.de>
	<1157590416.22705.269.camel@localhost.localdomain>
In-Reply-To: <1157590416.22705.269.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux1394-devel@lists.sourceforge.net,
	Bernhard Kaindl <bk@fsfe.org>, Pavel Machek <pavel@ucw.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Wed, 2006-09-06 at 16:46 +0200, Stefan Richter wrote:
[...]
>> We already broke your platform code once by what was meant as a bugfix
>> for non-PMacs. It'd be good to know enough to not repeat such mistakes...
> 
> The PowerMac code will stop the chip clocks. It should be used as the
> last step of the suspend sequence and first step of the return sequence,
> in _addition_ to your new code.

Thanks for the help.

> Note also that the code you posted lacks calls to pci_set_power_state()...

Pavel submitted a respective patch on 2006-09-05; I will integrate them
both.
-- 
Stefan Richter
-=====-=-==- =--= --===
http://arcgraph.de/sr/
