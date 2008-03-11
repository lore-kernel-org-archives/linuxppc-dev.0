Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id CF303DE4D1
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 08:32:18 +1100 (EST)
From: "Joakim Tjernlund" <Joakim.Tjernlund@transmode.se>
To: "'Anton Vorontsov'" <avorontsov@ru.mvista.com>,
	<linux-usb@vger.kernel.org>, <linuxppc-dev@ozlabs.org>
References: <20080311191744.GA10518@localhost.localdomain>
In-Reply-To: <20080311191744.GA10518@localhost.localdomain>
Subject: RE: [PATCH] Freescale QUICC Engine USB Host Controller
Date: Tue, 11 Mar 2008 22:32:07 +0100
Message-ID: <00aa01c883bf$5bfae2a0$13f0a7e0$@Tjernlund@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: linuxppc-dev-bounces+joakim.tjernlund=transmode.se@ozlabs.org [mailto:linuxppc-dev-
> bounces+joakim.tjernlund=transmode.se@ozlabs.org] On Behalf Of Anton Vorontsov
> Sent: den 11 mars 2008 20:18
> To: linux-usb@vger.kernel.org; linuxppc-dev@ozlabs.org
> Subject: [PATCH] Freescale QUICC Engine USB Host Controller
> 
> This is patch adds support for the FHCI USB controller, as found
> in the Freescale MPC836x and MPC832x processors. It can support
> Full or Low speed modes.
> 
> Quite a lot hardware is doing by itself (SOF generation, CRC generation
> and checking), though scheduling and retransmission is on the software
> shoulders.
> 
> This controller does not integrate the root hub, so this driver also
> fakes an one-port hub. External hub is required to support more than
> one device.

Cool, can one turn this into a gadget driver too?

       Jocke
