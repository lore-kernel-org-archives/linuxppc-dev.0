Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: watchdog in lite5200
Date: Wed, 16 Jun 2004 16:36:41 +0200
References: <20040615183624.B0BDAC13D3@atlas.denx.de>
In-Reply-To: <20040615183624.B0BDAC13D3@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406161636.44541.g.jaeger@sysgo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Wolfgang,

I checked out the driver and I'm wondering about the licence. From
what I can see in the header, it's NON-GPL - simply a mistake?

Ciao,
  Gerhard Jaeger

On Tuesday 15 June 2004 20:36, Wolfgang Denk wrote:
> In message <40CF0671.4040002@ztec.com.br> you wrote:
> > i am tring to use the watchdog in a lite5200
> > In menuconfig , i find the watchdog in char devices
> > but none of the cotrolers is for internal watchdog of mpc5200
> > In 5xxx/IO dont appear to show a driver for internal watchdog either.
> >
> > So i have to develop the driver for watchdog in mpc5200 ?
>
> No. Check out the recent version from our CVS  tree.  It  contains  a
> powerful  watchdog driver. For a documentation of the API, please see
> Documentation/man4/wdt_mpc8xx.4
>
> Best regards,
>
> Wolfgang Denk


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
