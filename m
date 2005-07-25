Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3D3EE67D50
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Jul 2005 03:00:20 +1000 (EST)
Date: Mon, 25 Jul 2005 10:00:17 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Frank Lautenbach <frank.lautenbach@gmx.de>
Message-ID: <20050725170017.GA29047@gate.ebshome.net>
References: <42E51849.7050800@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <42E51849.7050800@gmx.de>
Cc: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
Subject: Re: Getting a kernel to run on AMCC 440EP (Bamboo)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Jul 25, 2005 at 06:50:17PM +0200, Frank Lautenbach wrote:
> Hi folks,
> 
> I want to bring up a linux kernel on the AMCC 440EP board (Bamboo). 
> (still!  ;-) )
> 
> I managed to compile the kernel sources from kernel.org (2.6.12.3) with 
> a cross tool chain created with
> this great script from kegel.com (using demo-ppc440.sh). I set ARCH=ppc 
> and CROSS_COMPILE=powerpc-440-linux-gnu-
> during the configuration procedure (using xconfig) as well as for the 
> actual buil process. Of course, I also
> added the path to the ppc-crosstools to my PATH variable. Seems I did 
> all that right, because the build process succeeded.
> 
> Finally I got an zImage.elf file (among some other variants) after the 
> make process in .../arch/ppc/boot/images which I tried to load
> via TFTP of the PIBS ROM Monitor. After the image has been loaded into 
> RAM I get
> a lapidar "error: can not process ELF program header, status: command 
> rc=-1" and that's it...
> 
> When I examine the image file with readelf everything seems to be all 
> right. All data seems to be plausible
> and it is in fact a binary for PPC.
> 
> Anyhow seems to be wrong with the header format... Has anyone a guess 
> what's the problem? Is PIBS
> not able to load kernel images at all? Or do I have to create another 
> kind of image format?
> 

Try PIBS specific image (made with mktree). This image has 'RPO' 
letters at the beginning.

-- 
Eugene
