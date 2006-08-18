Return-Path: <olaf@ibook.aepfle.de>
Received: from natblert.rzone.de (natblert.rzone.de [81.169.145.181])
	by ozlabs.org (Postfix) with ESMTP id 59CE967A2E
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 17:01:26 +1000 (EST)
Date: Fri, 18 Aug 2006 09:01:13 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: booting with BootX corrupts memory
Message-ID: <20060818070113.GA28088@aepfle.de>
References: <1155096025.3813.6.camel@plutonium.opasia.dk>
	<1155873732.5803.16.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1155873732.5803.16.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Niels Kristian Bech Jensen <nkbj@mail.tele.dk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 18, 2006 at 02:02:12PM +1000, Benjamin Herrenschmidt wrote:
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

No, now I dont even get console= output on serial console.
