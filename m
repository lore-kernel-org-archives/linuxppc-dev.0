Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id ACDB3DDEDA
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 09:24:08 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n1CMO49K029073
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 15:24:05 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n1CMO4aL027589
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 16:24:04 -0600 (CST)
Date: Thu, 12 Feb 2009 16:24:03 -0600
From: Scott Wood <scottwood@freescale.com>
To: Jean-Michel Hautbois <jhautbois@gmail.com>
Subject: Re: [MPC8272ADS]Problem adding flash partitions inside the device tree
Message-ID: <20090212222403.GA10344@ld0162-tx32.am.freescale.net>
References: <8cad0aa0902120123p27cfe32fg6bf08d458178c937@mail.gmail.com>
	<49940265.1020700@vastech.co.za>
	<8cad0aa0902120310g44a3bf3cla4ffa94ea9bf5dc6@mail.gmail.com>
	<20090212133037.GA3651@yookeroo.seuss>
	<8cad0aa0902120536p3303322cvf9a7307391d195b9@mail.gmail.com>
	<49942D68.7080706@vastech.co.za>
	<8cad0aa0902120626v733011a5u669fc30096565d86@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8cad0aa0902120626v733011a5u669fc30096565d86@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 12, 2009 at 03:26:58PM +0100, Jean-Michel Hautbois wrote:
> I think that the problem is in the reg part, but I can't understand why.
> Isn't it the RAM mpping of my MTD that is the first address ?

No, it's the offset into the chipselect.

-Scott
