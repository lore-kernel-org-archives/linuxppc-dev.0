Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 04B022C0292
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Feb 2013 05:15:31 +1100 (EST)
Date: Fri, 1 Feb 2013 12:15:17 -0600
From: Scott Wood <scottwood@freescale.com>
Subject: Re: Why is the e500v2 core not using cpuidle?
To: Thomas Waldecker <Thomas.Waldecker@tqs.de>
In-Reply-To: <B88C075EE1324644BA0452D5EFDD58281395211D@TQ-MAIL.tq-net.de>
 (from Thomas.Waldecker@tqs.de on Fri Feb  1 06:06:05 2013)
Message-ID: <1359742517.23561.2@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: "Linux PPC dev mailing list \(linuxppc-dev@lists.ozlabs.org\)"
 <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/01/2013 06:06:05 AM, Thomas Waldecker wrote:
> Hi,
>=20
> As part of my masterthesis I was just looking around the kernel
> sources for cpuidle and figured out that the only CPU in the PowerPC
> architecture using the cpuidle framework is the pseries.
>=20
> I assume the e500v2 core is using the idle modes
> in arch/powerpc/kernel/idle_e500.S
>=20
> Why is there no support for the cpuidle framework?

Because nobody implemented it. :-)

The only reason I can think of to implement it on this chip would be to =20
dynamically choose when to enter nap versus doze, rather than always =20
just using doze.  It's not clear whether the difference in power =20
savings is worth it -- do you have any way of measuring?

> How can I debug the e500 idle modes?
> Are there any statistics?

Top reports idle percentage...

> I already ran PowerTOP on a QorIQ P2020 but it's almost useless
> because the information is missing.

What information are you looking for?

-Scott=
