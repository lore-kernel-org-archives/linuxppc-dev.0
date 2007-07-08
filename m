Return-Path: <bzolnier@gmail.com>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.188])
	by ozlabs.org (Postfix) with ESMTP id 8CDA4DDE2C
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Jul 2007 23:59:53 +1000 (EST)
Received: by mu-out-0910.google.com with SMTP id w1so417926mue
	for <linuxppc-dev@ozlabs.org>; Sun, 08 Jul 2007 06:59:51 -0700 (PDT)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] [ide] mmio ide support
Date: Sun, 8 Jul 2007 15:15:41 +0200
References: <20070707094852.9473.21013.stgit@localhost.localdomain>
	<468FC4AC.9030701@ru.mvista.com> <200707072007.10448.arnd@arndb.de>
In-Reply-To: <200707072007.10448.arnd@arndb.de>
MIME-Version: 1.0
Message-Id: <200707081515.42105.bzolnier@gmail.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

On Saturday 07 July 2007, Arnd Bergmann wrote:
> On Saturday 07 July 2007, Sergei Shtylyov wrote:
> > Arnd Bergmann wrote:
> > 
> > >>This adds support for MMIO IDE device like CompactFlash 
> > >>in TrueIDE mode.
> > 
> > >>Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com> 
> > >>Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
> > 
> > > Hmm, are we still adding new IDE drivers? Do you also have a
> > 
> >     Yes, why not?
> 
> The last time someone (I think Akira Iguchi) wanted to add
> a new powerpc specific IDE driver, that was rejected based

linux/drivers/ide/pci/scc_pata.c

New IDE host drivers are still fine.

> on the argument that drivers/ide/ is going away soon. Most
> current distros have already moved over to using libata
> exclusively.

The in-kernel default for PATA systems is still IDE subsystem.

Thanks,
Bart
