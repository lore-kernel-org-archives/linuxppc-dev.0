Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 383BE2BD6A
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Oct 2004 03:15:44 +1000 (EST)
In-Reply-To: <35fb2e5904100405451423c391@mail.gmail.com>
References: <35fb2e59040930165327f2dd59@mail.gmail.com>
	<87127382-1357-11D9-8EFC-000393DBC2E8@freescale.com>
	<20041001220648.GJ21896@smtp.west.cox.net>
	<4160E898.9080905@intracom.gr>
	<35fb2e5904100405451423c391@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <80A86B0F-1624-11D9-A7BA-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Mon, 4 Oct 2004 12:43:21 -0400
To: jonathan@jonmasters.org
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: bi_recs
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Oct 4, 2004, at 8:45 AM, Jon Masters wrote:

> I think that's an approach which works up to a point. It's nice to
> have a hierachy of devices like with OF because then we can infer
> things like order of devices on a bus that need to be shutdown for a
> suspend.

The problem with a hierarchy of devices is that isn't the kind of
information we need in an embedded system.  With the embedded
system, you have a pretty good idea what you have.  We need
_environment_ information, such as MAC addresses, memory sizes
and other information tidbits are are likely to vary within an embedded
system.  This is something an OF tree doesn't give us.

The OF tree is great for workstations or other highly configurable
systems where you don't know what kind of device is plugged into
a PCI bus and you have an OF function to initialize that device.
When you have a bunch of integrated peripherals, you know they
are present and you need unique configuration information for
them, not where they are located on the address bus (because
you already know that).

Thanks.


	-- Dan
