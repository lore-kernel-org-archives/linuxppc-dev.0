Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BDDD72C0080
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2012 09:27:22 +1100 (EST)
Date: Tue, 27 Nov 2012 16:27:10 -0600
From: Scott Wood <scottwood@freescale.com>
Subject: Re: problem with mpc8536 and kernel 2.6.32 and interrupts
To: Koen Swinters <Koen.Swinters@otnsystems.com>
References: <48749811B6A50F4994E931DDE5578FD4496F98EC0C@dca12.dcaad.local>
In-Reply-To: <48749811B6A50F4994E931DDE5578FD4496F98EC0C@dca12.dcaad.local>
 (from Koen.Swinters@otnsystems.com on Thu Nov 22 06:12:03 2012)
Message-ID: <1354055230.2317.15@tyr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/22/2012 06:12:03 AM, Koen Swinters wrote:
> We have a module from broadcom loaded that makes use of interrupts =20
> via PCI and interrupt driver FSL-MSI . When we disable this interrupt =20
> the coredumps dissapear.
> I`ve tried the following patch: =20
> 78e2e68a2b79f394b7cd61e07987a8a89af907f7. But is does not fix this =20
> problem.
> Does some-one know what is happenging here.

Ask Broadcom?

-Scott=
