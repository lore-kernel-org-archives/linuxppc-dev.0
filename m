Return-Path: <dwm@enoyolf.org>
Received: from bebe.enoyolf.org (bebe.enoyolf.org [24.173.215.190])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bebe.enoyolf.org",
	Issuer "CA Cert Signing Authority" (not verified))
	by ozlabs.org (Postfix) with ESMTP id BC781DDDFF
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 13:20:35 +1100 (EST)
In-reply-to: <20071130185304.2ea3aad3@zod.rchland.ibm.com> 
References: <1196403038.569525.367459803520.qpush@grosgo>
	<20071130141540.GA3117@lixom.net>
	<51DE5987-D0DD-4E62-A99A-3D23ECFA9908@kernel.crashing.org>
	<20071130152742.GB4196@lixom.net> <47503619.2010202@freescale.com>
	<20071130185304.2ea3aad3@zod.rchland.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/24] powerpc: 4xx PCI,
	PCI-X and PCI-Express support among others
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 30 Nov 2007 19:18:30 -0600
Message-ID: <16152.1196471910@bebe.enoyolf.org>
From: Doug Maxey <dwm@enoyolf.org>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 30 Nov 2007 18:53:04 CST, Josh Boyer wrote:
> On Fri, 30 Nov 2007 10:11:05 -0600
> Jon Loeliger <jdl@freescale.com> wrote:
> 
> > Olof Johansson wrote:
> > 
> > > I normally do "quilt diff | checkpatch.pl -" when use quilt. You could
> > > similarly do "git diff HEAD | checkpatch.pl -". You'd always get the
> > > warning about missing signed-off-by though.
> > 
> > So do a "git log -p | checkpatch.pl -" instead? :-)
> 
> That sort of defeats the purpose of running checkpatch.pl _before_ you
> commit things...

thank $DEITY for --amend :->
