Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B3C85DE1A1
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 06:04:55 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m09J4qKt006996
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 14:04:52 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m09J4oLJ120780
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 12:04:50 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m09J4oWr006055
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 12:04:50 -0700
Date: Wed, 9 Jan 2008 13:04:32 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH] MTD for Taco
Message-ID: <20080109130432.4606db26@zod.rchland.ibm.com>
In-Reply-To: <47851781.90105@pikatech.com>
References: <477F12D1.2070109@pikatech.com> <200801051041.18173.sr@denx.de>
	<47850CEF.9060209@pikatech.com>
	<20080109124243.73205d68@zod.rchland.ibm.com>
	<47851781.90105@pikatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 09 Jan 2008 13:50:41 -0500
Sean MacLennan <smaclennan@pikatech.com> wrote:

> No. You have to setup everything the old way. This *just* gets it 
> working so if you have the PPC layout, it will work.
> 
> Unless testing goes *really* well, I doubt I will have time in the short 
> term to port it to the of_platform. I'm afraid I will have to live with 
> "it works, don't touch it" for now :(

That's fine for you, nobody expects you to have to do all the porting
for everything :).

I don't want it actually ported to of_platform anyway. What I really
want, and what Stefan has started some time ago, is to make it get the
values from the device tree but still create the regular platform
devices.

josh
