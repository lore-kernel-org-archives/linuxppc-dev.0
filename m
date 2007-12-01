Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 79311DDDE7
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 11:54:43 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lB10sdD4000658
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 19:54:39 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lB10sddO463670
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 19:54:39 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lB10sd6V022888
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 19:54:39 -0500
Date: Fri, 30 Nov 2007 18:53:04 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH 0/24] powerpc: 4xx PCI, PCI-X and PCI-Express support
	among others
Message-ID: <20071130185304.2ea3aad3@zod.rchland.ibm.com>
In-Reply-To: <47503619.2010202@freescale.com>
References: <1196403038.569525.367459803520.qpush@grosgo>
	<20071130141540.GA3117@lixom.net>
	<51DE5987-D0DD-4E62-A99A-3D23ECFA9908@kernel.crashing.org>
	<20071130152742.GB4196@lixom.net> <47503619.2010202@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 30 Nov 2007 10:11:05 -0600
Jon Loeliger <jdl@freescale.com> wrote:

> Olof Johansson wrote:
> 
> > I normally do "quilt diff | checkpatch.pl -" when use quilt. You could
> > similarly do "git diff HEAD | checkpatch.pl -". You'd always get the
> > warning about missing signed-off-by though.
> 
> So do a "git log -p | checkpatch.pl -" instead? :-)

That sort of defeats the purpose of running checkpatch.pl _before_ you
commit things...

josh
