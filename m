Return-Path: <g.liakhovetski@gmx.de>
Date: Thu, 17 Aug 2006 22:16:16 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 6/6] bootwrapper: Add support for the sandpoint platform
In-Reply-To: <20060719231725.GG3887@mag.az.mvista.com>
Message-ID: <Pine.LNX.4.60.0608172200080.8228@poirot.grange>
References: <20060719231725.GG3887@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 19 Jul 2006, Mark A. Greer wrote:

> This patch adds support for the Freescale Sandpoint platform
> to the bootwrapper.

Mark,

you put sandpoint.c and mpc10x.c under boot... I don't quite understand 
your concept now: you mean this is the code needed to __boot__ sandpoint. 
Ok. I can also imagine that as soon as the system is up you don't need any 
further specific code - only .init* sections. But - does this mean that 
every platform will now put its support flat under boot? Or is it a 
special case? Or are there also run-time fixups that you didn't include 
with this patch-series? Also <board>_reset doesn't quite fit under boot, 
or am I misunderstanding something?

Thanks
Guennadi
---
Guennadi Liakhovetski
