Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17917.55985.39690.519943@cargo.ozlabs.ibm.com>
Date: Mon, 19 Mar 2007 11:34:57 +1100
From: Paul Mackerras <paulus@samba.org>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [RFC PATCH] power-management elements for 603e/fsl
In-Reply-To: <Pine.LNX.4.60.0703182216130.4143@poirot.grange>
References: <Pine.LNX.4.60.0703182216130.4143@poirot.grange>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Guennadi Liakhovetski writes:

> As some of you would know, it is not a real suspend-to-RAM, since kurobox' 
> hardware doesn't support powering down CPU and peripherals while keeping 
> RAM in self-refresh. So, this patch just sends the SoC and the CPU to 
> SLEEP. It also needs some extra patches for timer suspend / resume, so, 

The early powerbooks also put the CPU into sleep mode, rather than
powering it off, so I think you can say that what you are doing is
suspend to RAM, as long as it manages to reduce power consumption
substantially, and you have a way to wake it up (e.g. via a keypress
or a LAN packet).

> this alone will not work properly. Besides, I am not where to put and how 
> to call these functions. So far I put them in fsl namespace as that'll, 
> probably, be similar among Freescale chips? Maybe it's better to call this 
> mode standby, not str?

What you have done looks OK to me.  If we need to move things around
later, that can be done easily enough.

Paul.
