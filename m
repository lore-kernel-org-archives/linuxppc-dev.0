Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C4FD9DDDA2
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 05:37:47 +1100 (EST)
Date: Wed, 18 Mar 2009 13:37:26 -0500
From: Scott Wood <scottwood@freescale.com>
To: liran raz <liranrazlinux@gmail.com>
Subject: Re: node /dev/ttyCPM2 not created
Message-ID: <20090318183726.GC3410@loki.buserror.net>
References: <e3b3ab5c0903131156l45ab934fyf7fb33b71468594a@mail.gmail.com>
	<ed82fe3e0903131718u2d49cad3j78e2d08d4de0bf4a@mail.gmail.com>
	<e3b3ab5c0903160639u625a0fd3xa665896bb378b109@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e3b3ab5c0903160639u625a0fd3xa665896bb378b109@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@tabi.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 16, 2009 at 05:39:08AM -0800, liran raz wrote:
> Thanks, I don't see any mdev process running.

Does it run during the boot scripts?  Or do you have udev?

> Just wonder who is creating /dev/ttyCPM1 since in the device table file
> (device_table.txt)
> I have only node: 204 (major) 46 (minor) defined.
> But I can see /dev/ttyCPM1 (204 47)

Ideally, it would be a program such as udev or mdev.  If you're using a
static /dev with no utility to automatically create nodes, then it's *you*
that creates it, with mknod. :-)

-Scott
