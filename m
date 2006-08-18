Return-Path: <nkbj@mail.tele.dk>
Received: from fep33.mail.dk (fep33.mail.dk [80.160.76.197])
	by ozlabs.org (Postfix) with ESMTP id 4D05667A3D
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 22:10:16 +1000 (EST)
Subject: Re: booting with BootX corrupts memory
From: Niels Kristian Bech Jensen <nkbj@mail.tele.dk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1155873732.5803.16.camel@localhost.localdomain>
References: <1155096025.3813.6.camel@plutonium.opasia.dk>
	<1155873732.5803.16.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 14:10:11 +0200
Message-Id: <1155903011.4357.1.camel@plutonium.opasia.dk>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-08-18 at 14:02 +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2006-08-09 at 06:00 +0200, Niels Kristian Bech Jensen wrote:
> >  On Tue, Aug  1, Olaf Hering wrote:
> > 
> > > Booting an old Mac with BootX corrupts memory, the kernel seldom gets
> > > into init. Even the built-in initramfs archive gets corrupted. So far I
> > > havent figured out where the corruption starts. The only data point so
> > > far is that a passed initrd gets overwritten with stuff that looks like
> > > part of the device-tree after the call to free_area_init_node() from
> > > paging_init(). Perhaps the virtual/real address mapping isnt handled
> > > correctly.
> > 
> > > This is broken since at least 2.6.15, 2.6.14 dies very early, 2.6.13 was
> > > still ok.
> > 
> > > Symptoms differ, depending on used .config and wether an initrd is passed.
> > 
> > I think I've been hit by this bug on my beige G3 running Ubuntu Edgy.
> > 
> > When booting with initrd the boot process stops before any kernel output (CONFIG_BOOTX_TEXT is not enabled).
> > Booting without initrd works fine - at least until it cannot find the root filesystem driver. ;-)
> 
> Does this patch helps ?
> 
Yes, it fixes the problem for me. Thanks.

-- 
Niels Kristian Bech Jensen

Stop software piracy --- use free software.
