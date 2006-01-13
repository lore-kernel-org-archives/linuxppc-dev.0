Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 86619689C8
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jan 2006 12:53:49 +1100 (EST)
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple PowerBooks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
In-Reply-To: <20060112233951.GA31258@hansmi.ch>
References: <20051225212041.GA6094@hansmi.ch>
	<200512252304.32830.dtor_core@ameritech.net>
	<1135575997.14160.4.camel@localhost.localdomain>
	<d120d5000601111307x451db79aqf88725e7ecec79d2@mail.gmail.com>
	<20060111232651.GI6617@hansmi.ch>
	<1137022900.5138.66.camel@localhost.localdomain>
	<20060112090733.GA7627@midnight.suse.cz>
	<20060112233951.GA31258@hansmi.ch>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 12:53:23 +1100
Message-Id: <1137117204.4862.0.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-kernel@killerfox.forkbomb.ch, dtor_core@ameritech.net,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Vojtech Pavlik <vojtech@suse.cz>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-01-13 at 00:39 +0100, Michael Hanselmann wrote:
> On Thu, Jan 12, 2006 at 10:07:33AM +0100, Vojtech Pavlik wrote:
> > I think having it in struct hid_device is safer. We might want to
> > dynamically allocate only for PowerBook keyboards, though, to save
> > memory.
> 
> These two arrays take 128 Bytes. I don't think it's possible to write
> the code to allocate and set them in such short code. Beside of that, it
> would affect more code than only hid-input.c, at least hid-core.c would
> need modifications, too.
> 
> Benjamin Herrenschmidt had the idea of a private field which each device
> can use for its own purposes. That's a task for another patch, tough.
> 
> This patch implements support for the fn key on Apple PowerBooks using
> USB based keyboards.

Dimitri, I think the patch is good enough now and should go in for
2.6.16.

Thanks !
Ben.
