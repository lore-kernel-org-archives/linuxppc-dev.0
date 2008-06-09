Return-Path: <jonsmirl@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 3BC61DDFBF
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Jun 2008 22:37:54 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so1199068ywh.39
	for <linuxppc-dev@ozlabs.org>; Mon, 09 Jun 2008 05:37:51 -0700 (PDT)
Message-ID: <9e4733910806090537y73d29280ofce1ce04086dae5d@mail.gmail.com>
Date: Mon, 9 Jun 2008 08:37:51 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Juergen Beisert" <jbe@pengutronix.de>
Subject: Re: Comments on device tree for pcm030
In-Reply-To: <200806090956.32160.jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910806081208r1a8d0987j6eab0d73bc446640@mail.gmail.com>
	<fa686aa40806081628s2632bcb3he21b26e49873a65f@mail.gmail.com>
	<200806090956.32160.jbe@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, wsa@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 6/9/08, Juergen Beisert <jbe@pengutronix.de> wrote:
>  > > Device tree has an entry for AC97 on PSC1. I don't think the Phytec
>  > > module or carrier board has AC97 hardware.
>  >
>  > Might be a bug
>
>
> NACK. The baseboard for the pcm030 CPU board has AC97 hardware connected to
>  PSC1. And it plays audio...

I'm staring at a baseboard for the pcm030 in my hand, I don't see any
AC97 hardware. It has two serial, two CAN, ethernet and power. Where's
the AC97?

http://www.phytec.com/products/rdk/PowerPC/phyCORE-MPC5200B-tinyRDK.html

-- 
Jon Smirl
jonsmirl@gmail.com
