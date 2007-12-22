Return-Path: <SRS0=MfzD=RN=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 3B4EFDDE21
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 16:59:19 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org,
 benh@kernel.crashing.org
Subject: Re: [PATCH 3/4] PowerPC: Add PCI entry to 440EPx Sequoia DTS.
Date: Sat, 22 Dec 2007 06:53:38 +0100
References: <20071221162601.GA1700@ru.mvista.com>
	<1198272085.6737.6.camel@pasglop>
In-Reply-To: <1198272085.6737.6.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712220653.38922.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 21 December 2007, Benjamin Herrenschmidt wrote:
> On Fri, 2007-12-21 at 19:26 +0300, Valentine Barshak wrote:
> > +
> > +                       /* All PCI interrupts are routed to IRQ 67 */
> > +                       interrupt-map-mask = <0000 0 0 0>;
> > +                       interrupt-map = < 0000 0 0 0 &UIC2 3 8 >;
> > +               };
> >         };
>
> Wow, all 4 lines of all slots ?

Yes, that's unfortunately correct. :-(

Best regards,
Stefan
