Return-Path: <wd@denx.de>
Received: from mailout03.sul.t-online.com (mailout03.sul.t-online.com
	[194.25.134.81]) by ozlabs.org (Postfix) with ESMTP id 43B8967A81
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jan 2005 10:06:01 +1100 (EST)
To: "Jordan, Kyle" <kylej@aiinet.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 19 Jan 2005 15:28:23 EST."
	<C0170D0AF1277849A4B4518034F855DD0F90C6@aiexchange.ai.aiinet.com>
Date: Thu, 20 Jan 2005 00:05:38 +0100
Sender: wd@denx.de
Message-Id: <20050119230543.16A32C108D@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: ISP1362 USB host controller with an MPC880 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <C0170D0AF1277849A4B4518034F855DD0F90C6@aiexchange.ai.aiinet.com> you wrote:
>
> 	I am currently looking into using the ISP1362 as a host
> controller on a Freescale (Motorola) MPC880 running Linux 2.4.23.  I
> have noticed posts where others have also use this part with the MPC880.
> I was wondering if anyone could let me know what driver they were using
> and where I could possibly obtain it.  If anyone could also tell me if
> they were successful using this driver, I would greatly appreciate it.

See the linuxppc_2_4_devel module on our CVS server. Our  driver  for
the  ISP1362  has  been  tested  for host function (memory stick, USB
modem, USB-serial adapter,  USB  network  adapter),  device  function
(network  device) and as gadget driver (communicating with Windows PC
using RNDIS drivers).

The code is stable.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Crash programs fail because they are based on the theory  that,  with
nine women pregnant, you can get a baby a month.  - Wernher von Braun
