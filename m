Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DEE212C00C0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Aug 2013 12:32:42 +1000 (EST)
Message-ID: <1376274739.32100.149.camel@pasglop>
Subject: Re: Failure to detect PCI card
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter LaDow <petela@gocougs.wsu.edu>
Date: Mon, 12 Aug 2013 12:32:19 +1000
In-Reply-To: <CAN8Q1EczGM+aQMPti+QdvUHHbsn=ARV7sKptXc5M7gvEFoDkKQ@mail.gmail.com>
References: <CAN8Q1Ed-YtD1L7e9TaJyELdcz5Rcfdi0mdwU_H6HAx0-3FJ4Lg@mail.gmail.com>
 <20130805202559.0086e806@crub>
 <CAN8Q1EfoLTDr-x0r82Ezpqak+R=QuL1o37_OVU3Q0=8zFfDMqA@mail.gmail.com>
 <52000ACA.1010606@ovro.caltech.edu>
 <CAN8Q1EecMBWb_wKVOGnBJ=CHZ9zQQDKjwN5ZD4DkP30+QRerPA@mail.gmail.com>
 <CAN8Q1EfWOedMFKtFQbTmmydnLoLe24=c3Fo1Ao3sTdDmuYBJqQ@mail.gmail.com>
 <520058E0.8080304@ovro.caltech.edu>
 <CAN8Q1EczGM+aQMPti+QdvUHHbsn=ARV7sKptXc5M7gvEFoDkKQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org,
 David Hawkins <dwh@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-08-08 at 13:31 -0700, Peter LaDow wrote:
> For those that are interested, we did figure out what was going on.
> Turns out that the clock buffer driving the PCI connector was, well,
> less than adequate.  With some cards, the load on the clock line was
> large enough that the clock was in horrible shape.  Fixing the clock
> line and the card that failed to be recognized started working.  For
> the other cards that worked, the load on the clock line was
> significantly less, but the clock was still marginal.
> 
> Anyway, turned out to be a hardware issue.  Thanks to all that helped!

Do that help with e1000 as well ? IE. A bad clock might have caused
malfunctions of the DMA for example...

Cheers,
Ben.
