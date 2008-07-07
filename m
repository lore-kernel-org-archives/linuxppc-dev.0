Return-Path: <jonsmirl@gmail.com>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.183])
	by ozlabs.org (Postfix) with ESMTP id DB86DDE516
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 00:50:48 +1000 (EST)
Received: by el-out-1112.google.com with SMTP id o28so168084ele.3
	for <linuxppc-dev@ozlabs.org>; Mon, 07 Jul 2008 07:50:47 -0700 (PDT)
Message-ID: <9e4733910807070750v3aebc084v313b877ef8f035ba@mail.gmail.com>
Date: Mon, 7 Jul 2008 10:50:47 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Matt Sealey" <matt@genesi-usa.com>
Subject: Re: MPC52xx generic DMA using bestcomm
In-Reply-To: <487225C4.90405@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4871E487.2020008@matrix-vision.de>
	<4872104E.6050109@genesi-usa.com>
	<9e4733910807070639k283b1267q34a4c9bbff827b22@mail.gmail.com>
	<487225C4.90405@genesi-usa.com>
Cc: Andre Schwarz <andre.schwarz@matrix-vision.de>,
	linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/7/08, Matt Sealey <matt@genesi-usa.com> wrote:
>
>  Jon Smirl wrote:
>
> > On 7/7/08, Matt Sealey <matt@genesi-usa.com> wrote:
> >
> > >
> > >
> > to do that the samples have to be alternated as they are fed into the
> > AC97 stream.  I think the codec can capture that way too but you
> > didn't put a transceiver on the S/PDIF line.
> >
>
>  OT, but the IDT STAC9766 doesn't support S/PDIF input, only output.
>
>
> > In my test driver you only get AC97 or S/PDIF. Grant and I are both
> > working on i2s drivers, when we get those sorted out it shouldn't be
> > too hard to add ac97 back in. That codec driver I sent you was about
> > 95% complete.
> >
>
>  Indeed and to be honest I only gave it a short glance before having to
>  do about a thousand other things, but I will take another peek some
>  time this week :)

You should junk my PSC and DMA code and switch to the code Grant
recently posted. Codec should work as is. My PSC code is for a six
month old version of ASOC v2.

Grant's PSC driver needs to be split into a DMA library and i2s
driver. Then make an AC97 version based on his i2s driver that uses
the DMA library. Not hard once he splits the i2s driver.

We are getting closer to having full featured audio drivers for the
mpc5200 platform.


>
>  --
>  Matt Sealey <matt@genesi-usa.com>
>  Genesi, Manager, Developer Relations
>


-- 
Jon Smirl
jonsmirl@gmail.com
