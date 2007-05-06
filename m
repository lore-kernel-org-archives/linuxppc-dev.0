Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 38285DDEF7
	for <linuxppc-dev@ozlabs.org>; Mon,  7 May 2007 06:20:33 +1000 (EST)
Date: Sun, 6 May 2007 22:20:36 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Bodo Eggert <7eggert@gmx.de>
Subject: Re: Correct location for ADC/DAC drivers
In-Reply-To: <E1Hkfia-0000cJ-18@be1.lrz>
Message-ID: <Pine.LNX.4.60.0705062219310.6650@poirot.grange>
References: <8fZXU-3EI-11@gated-at.bofh.it> <8haHG-6zd-19@gated-at.bofh.it>
	<8hd2U-1Ca-39@gated-at.bofh.it> <8heii-3GM-37@gated-at.bofh.it>
	<E1Hkfia-0000cJ-18@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Robin Getz <rgetz@blackfin.uclinux.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 6 May 2007, Bodo Eggert wrote:

> Robin Getz <rgetz@blackfin.uclinux.org> wrote:
> > On Fri 4 May 2007 16:52, Robert Schwebel pondered:
> >> On Fri, May 04, 2007 at 02:21:50PM -0400, Robin Getz wrote:
> 
> >> > We also have DAC and ADC drivers (up to 16 bits @ 64MS/s, via DMA),
> >> > that would be nice to put in the "right" place  - I don't think that
> >> > drivers/char is the right place, nor drivers/misc - I also don't think
> >> > that /adc is a descriptive place for DAC or mixed signal front ends
> >> > (MxFE).
> >>
> >> What userspace interface do your drivers have?
> > 
> > Right now, it is a little rudimentary char interface, it needs a little care
> > to be a bit more general purpose, but it suited needs of what the people who
> > were using it.

If I were thinking about a DAC / ADC API I would have a look at Comedi - 
somehow I think it should be pretty well designed...

Thanks
Guennadi
---
Guennadi Liakhovetski
