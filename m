Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 68717B70B8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Jun 2009 11:20:04 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AB592DDD0C
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jun 2009 11:20:02 +1000 (EST)
Subject: Re: sym scsi driver problem with 2.6.26 or newer debian kernel on
	p610 (fwd)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: blackluck@ktk.bme.hu
In-Reply-To: <4A3F4A77.6070704@ktk.bme.hu>
References: <Pine.LNX.4.64.0906141105050.4412@axis700.grange>
	<4A38B883.80507@ktk.bme.hu>  <4A3F4A77.6070704@ktk.bme.hu>
Content-Type: text/plain
Date: Tue, 23 Jun 2009 11:18:10 +1000
Message-Id: <1245719890.4017.26.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-06-22 at 11:10 +0200, Laszlo Fekete wrote:
> Hello!
> 
> Is there any idea for the solution?

Hard to tell yet. Looks indeed like something is wrong with the
interrupt controller.

Any chance you can bisect that ? I'll also have a look on my side,
it's definitely not something obvious.

Cheers,
Ben.

> Thanks: blackluck
> 
> Laszlo Fekete wrote:
> > Hello!
> >
> > I'm sorry about the annoyances, but I'd welcome all ideas, suggestions 
> > to see what needs to be done or should be tested for the solution.
> >
> > Thank you very much!
> >
> > Guennadi Liakhovetski wrote:
> >> Ok, first attempt to forward this to scsi was wrong, as pointed out 
> >> by Matthew Wilcox this does indeed look like an interrupt problem - 
> >> no interrupts drom SCSI, IDE, keyboar. Might be a known problem, I 
> >> guess. In any case, I think, the OP would be grateful for any hints.
> >>
> >> Thanks
> >> Guennadi
> >> ---
> >> Guennadi Liakhovetski, Ph.D.
> >> Freelance Open-Source Software Developer
> >> http://www.open-technology.de/
> >>
> >> ---------- Forwarded message ----------
> >> Date: Sat, 13 Jun 2009 16:22:07 +0200
> >> From: Laszlo Fekete <blackluck@ktk.bme.hu>
> >> To: debian-powerpc@lists.debian.org
> >> Subject: sym scsi driver problem with 2.6.26 or newer debian kernel 
> >> on p610
> >> Resent-Date: Sat, 13 Jun 2009 14:29:55 +0000 (UTC)
> >> Resent-From: debian-powerpc@lists.debian.org
> >>
> >> This is a multi-part message in MIME format.
> >> ------------------------------------------------------------------------
> >>
> >> Hello!
> >>
> >>
> >>
> >>
> >>
> >> Pls help me with sym scsi driver problem.
> >>
> >>
> >>
> >> I have Ibm P610 (and tested it on P630 and P640 too), installed debian
> >>
> >> etch and upgraded to lenny.
> >>
> >>
> >>
> >> But with 2.6.26 or newer kernel it's not booting, it's hang on sym scsi
> >>
> >> bus scan.
> >>
> >>
> >>
> >>
> >>
> >> Whats the problem with it, or how can I fix this?
> >>
> >>
> >>
> >>
> >>
> >> I attach the output from minicom with 2.6.29, 2.6.26, and the working
> >>
> >> 2.6.24 kernel booting.
> >>
> >>
> >>
> >>
> >>
> >> Thank you very much!
> >>
> >>
> >>   
> >
> >
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
