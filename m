Return-Path: <jdl@jdl.com>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH] powerpc: 85xx: add proper OF bus ids for the TQM85xx 
In-reply-to: <48A7E95C.4090501@grandegger.com> 
References: <48898470.80109@grandegger.com>
	<fa686aa40807250620r1ab574basd07ecce6be2bc238@mail.gmail.com>
	<4889EE4C.9040705@grandegger.com> <4889F180.80203@freescale.com>
	<4889F32F.3020606@grandegger.com> <48A7E95C.4090501@grandegger.com>
Date: Sun, 17 Aug 2008 10:52:57 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1KUkYr-0001pU-El@jdl.com>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Wolfgang Grandegger wrote:
> > Jon Loeliger wrote:
> >>
> >> Hmmmm..... While you are there, I think you should drop
> >> the "8548" part of "soc8548" to get just "soc@e0000000".
> > 
> > Well, right. I'm going to check the tqm8548.dts file more carefully.
> 
> Looking into 2.6.27-rc3, I realized that these issues have not yet been
> fixed :-(. I just sent out a patch for 2.6.27 doing so:
> 
>   http://ozlabs.org/pipermail/linuxppc-dev/2008-August/061725.html

Thanks!

jdl
