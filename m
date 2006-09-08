Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 5C6FE67B92
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Sep 2006 06:16:08 +1000 (EST)
Date: Fri, 8 Sep 2006 22:16:08 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: John Rigby <jcrigby@gmail.com>
Subject: Re: powerpc power management
In-Reply-To: <4b73d43f0609080718g743b9e6bje7202e5293c0abaa@mail.gmail.com>
Message-ID: <Pine.LNX.4.60.0609082147200.4572@poirot.grange>
References: <4b73d43f0609071905j26ab0317k144d78963e041cba@mail.gmail.com>
	<450121E2.5050207@in.ibm.com>
	<4b73d43f0609080718g743b9e6bje7202e5293c0abaa@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi John

On Fri, 8 Sep 2006, John Rigby wrote:

> MPC5200 which has a 603 core.
> 
> On 9/8/06, Vaidyanathan S <svaidy@in.ibm.com> wrote:
> > Hi John,
> >
> > John Rigby wrote:
> > > I need to implement suspend to ram (sleep mode) on an embedded powerpc
> > > processor.  I have googled generally and searched the lkml, this list
> > > and the linux power management mailing list.  It seems after all this
> > > searching that the only existing code is for the powermac in
> > > drivers/macintosh/(variousfiles) and
> > > arch/powerpc/platforms/powermac/(variousfiles).  Is this true or am I
> > > missing something?

I've been also playing with these ideas for a few weeks now, but before I 
can start with that I have to port my board from arch/ppc to arch/powerpc, 
which also means fdt support, new booting code, etc. But if I manage that, 
I hope I'll get back to those ideas - if somebody doesn't do it before me, 
which, actually, would be quite nice:-)

Is your board already using ARCH=powerpc or ARCH=ppc? If the latter, I am 
afraid, you'd need to port it under powerpc first. Don't think it makes 
much sense doing new developments under arch/ppc now.

As far as I understand, power-management code is also in flux, so, that 
won't be easy either...

If you do start working on str, I'll try to be useful at least with 
testing:-)

Thanks
Guennadi
---
Guennadi Liakhovetski
