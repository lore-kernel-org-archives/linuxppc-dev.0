Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8BC711007D1
 for <linuxppc-dev@ozlabs.org>; Fri, 25 Nov 2011 16:25:36 +1100 (EST)
Message-ID: <1322198727.32635.25.camel@pasglop>
Subject: Re: ibm_newemac tx problem with jumbo frame enabled
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Prashant Bhole <prashantsmailcenter@gmail.com>
Date: Fri, 25 Nov 2011 16:25:27 +1100
In-Reply-To: <CAD6p20dmksH7YEjijdqLRG06aigaKTpzLPdoL0SCNGD3Ji9d2A@mail.gmail.com>
References: <CAD6p20dmksH7YEjijdqLRG06aigaKTpzLPdoL0SCNGD3Ji9d2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-11-18 at 10:33 +0530, Prashant Bhole wrote:
> Hi,
> I have been facing problem with ibm_newemac driver (v3.54).
> The board gets disconnected and can not be pinged in between
> some heavy network traffic. In my case I am running IOmeter
> "All-in-One" 8 threads on the iSCSI target. MTU is 4088.
> 
> I found that after executing emac_full_tx_reset(), the board can
> be pinged again. Again after some heavy traffic of 5-6 seconds,
> traffic stops. This can be repeated after full tx reset.
> 
> Is this a known issue? what could cause this?
> Any pointers would be greatly appreciated.

Not that I know of. Can you check if any of the error reporting
registers trip anything ? Could it just be a fifo overflow which we may
not be handling properly in the driver ?

Cheers,
Ben.
