Return-Path: <azummo-lists@towertech.it>
Received: from mail.towertech.it (jack.kinetikon.it [62.152.125.81])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.towertech.it",
	Issuer "mail.towertech.it" (not verified))
	by ozlabs.org (Postfix) with ESMTP id DB59768926
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Dec 2005 02:07:15 +1100 (EST)
Date: Wed, 21 Dec 2005 16:07:12 +0100
From: Alessandro Zummo <azummo-lists@towertech.it>
To: Simon Richter <Simon.Richter@hogyros.de>
Message-ID: <20051221160712.2d322f42@inspiron>
In-Reply-To: <43A94811.4010704@hogyros.de>
References: <20051220220022.4e9ff931@inspiron>
	<43A94811.4010704@hogyros.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org,
	lm-sensors@lm-sensors.org, linux-arm-kernel@lists.arm.linux.org.uk,
	nslu2-developers@yahoogroups.com
Subject: Re: [RFC] RTC subsystem
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 21 Dec 2005 13:18:25 +0100
Simon Richter <Simon.Richter@hogyros.de> wrote:

> >   I've posted a proposal for a new RTC subsystem
> >  on lkml ( http://lkml.org/lkml/2005/12/20/220 ) .
> 
> I agree that there is room for improvement. Do you have a specific 
> structure in mind? Specifically,

 Hi Simon,
  the proposal actually had a fully-working patch attached :)

>   - which functions do you believe to be generic,
>   - how should multiple RTCs be handled,

 In my code, the first rtc that register is bound
 to /proc/driver/rtc and /dev/rtc (if those interfaces
 are compiled in, as they are all selectable).

 The other RTCs are available thru /sys/class/rtc/rtcX
 (again, if compiled in).

>   - are read-only (radio controlled) RTCs taken care of?

 You have full control of which functions you will provide
 to the upper layer. Obivously if you try to set the
 time on a read-only rtc, you will get an error.

> At present, I don't have time to help the cause, but I can provide 
> hosting for a git tree if desired.

 Thanks, I'll consider it if the need arises.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it
