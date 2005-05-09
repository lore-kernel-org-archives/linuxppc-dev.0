Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 041C4679F1
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 May 2005 02:58:27 +1000 (EST)
In-Reply-To: <9EDE1664710B26419A57B21CBCBB8D0B01950175@XY01EX01.xy01.xyratex.com>
References: <9EDE1664710B26419A57B21CBCBB8D0B01950175@XY01EX01.xy01.xyratex.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Message-Id: <e402bb363cdf2e59ae7ae8a1bc2f8654@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 9 May 2005 11:58:23 -0500
To: "Kostantinos Baliotis" <Kostantinos_Baliotis@xyratex.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: mpc 83xx immap_t question 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 9, 2005, at 11:16 AM, Kostantinos Baliotis wrote:

> Hi folks,
>
> =A0
>
> I=92m trying to port a custom driver to mpc8343E processor (a =
relatively=20
> new one). I would be grateful if someone could point me out some links=20=

> with specific patches, sources (or if it is possible the appropriate=20=

> cross compile tool chain) for this target CPU.

It uses a 603 based core so any standard PPC cross compiler should be=20
fine.

> At this stage my main concern is if this new freescale=20
> embedded=A0processor supports the immap_t structure (known from the =
good=20
> old mpc860).

Not exactly sure what you are mean here.  However, there are not any=20
plans to create master immap_t structures anymore.

> I should mention that I=92m using a 2.4 Linux kernel at the moment.

2.6 has basic support for 834x in 2.6.12-rc4.

- kumar=
