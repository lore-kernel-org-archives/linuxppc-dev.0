Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7CD79DDDA1
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2009 05:09:04 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n1GI8wcr010616
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2009 11:08:59 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n1GI8wL3011804
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2009 12:08:58 -0600 (CST)
Date: Mon, 16 Feb 2009 12:08:58 -0600
From: Scott Wood <scottwood@freescale.com>
To: Vijay Nikam <vijay.t.nikam@gmail.com>
Subject: Re: Regarding irq_of_parse_and_map
Message-ID: <20090216180857.GA18069@ld0162-tx32.am.freescale.net>
References: <f234e2140902160355p148c99d1qc2e5b6f6ae9a716f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f234e2140902160355p148c99d1qc2e5b6f6ae9a716f@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Feb 16, 2009 at 05:25:23PM +0530, Vijay Nikam wrote:
> 2. Also I would like to ask how I can determine the virtual irq using
> irq_of_parse_and_map (struct device_node *dev, int index)  ? ? ?
> 
> here I am not getting what I should pass *dev and index ? ? ? as in my
> mpc8313erdb.dts I could not find any node name 'gpio' so I do not know
> what I can use ...

You'd need to add a gpio node to the device tree.  If you do this, be
sure to follow existing bindings.

> 
> Kindly please acknowledge ... thank you ...
> 
> Following is the content of mpc8313erdb.dts

That device tree looks very old, as if it came from a BSP rather than
upstream Linux.

-Scott
