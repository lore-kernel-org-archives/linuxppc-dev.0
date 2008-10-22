Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 8198DDDE09
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 00:50:49 +1100 (EST)
Date: Wed, 22 Oct 2008 17:50:46 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: [PATCH] powerpc: Remove device_type = "rtc" properties in .dts
	files
Message-ID: <20081022135046.GA30347@oksana.dev.rtsoft.ru>
References: <20081021185844.GA31070@oksana.dev.rtsoft.ru>
	<48FF2CBB.7060605@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <48FF2CBB.7060605@genesi-usa.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 22, 2008 at 08:38:03AM -0500, Matt Sealey wrote:
> I'm extremely troubled that it is "not used in the code", surely 
> device_type is checked as a legacy for Open Firmware (otherwise a lot of 
> devices may never be detected!),

Checked where? Can you point out a code snippet? (Except for CHRP
platforms, the CHRP is running real OF, so it is irrelevant if it
checks for device_type = "rtc" or not.)

> or does device tree parsing/checking 
> follow a different path for FDT?
>
> (absolutely fine with it being removed from new DTS but, just concerned 
> about your comment and it's impact...)

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
