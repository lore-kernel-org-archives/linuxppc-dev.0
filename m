Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 43FCEDDDF3
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Sep 2008 04:21:30 +1000 (EST)
Message-ID: <48DBD6A3.7070102@freescale.com>
Date: Thu, 25 Sep 2008 13:21:23 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC] GPIO-Watchdog in devicetree
References: <20080922194357.GA32041@pengutronix.de>	
	<20080923150256.GC13593@secretlab.ca>	
	<20080925175907.GA4747@ld0162-tx32.am.freescale.net>
	<fa686aa40809251110t1493e74bucd142f10c242f004@mail.gmail.com>
In-Reply-To: <fa686aa40809251110t1493e74bucd142f10c242f004@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Thu, Sep 25, 2008 at 11:59 AM, Scott Wood <scottwood@freescale.com> wrote:
>> On Tue, Sep 23, 2008 at 09:02:56AM -0600, Grant Likely wrote:
>>> For example:
>>> / {
>>>       model = "pengutronix,super-sexy-board";
>>>       #address-cells = <1>;
>>>       #size-cells = <1>;
>>>       super-sexy-board,watchdog-gpio = <&gpio_simple 19 0>;
>>>       ...
>>> }
>> Why as a property of the root node, and not as a node with a very
>> specific compatible property?
> 
> Because the root node is the only logical board-level node we have
> right now.  However, I'm not deeply committed to this approach.  The
> only question I have about putting it in another node is choosing the
> parent node.  I don't think it fits to make it a child of the SoC node
> or any other bus node.

A child of the gpio controller node seems most logical, though a child 
of the root node would be OK.  It was the freefloating property that 
struck me as a little odd.

-Scott
