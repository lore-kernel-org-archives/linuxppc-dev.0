Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
 by ozlabs.org (Postfix) with ESMTP id 6F05F2C007A
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Aug 2013 08:10:47 +1000 (EST)
Message-ID: <52041765.30501@ovro.caltech.edu>
Date: Thu, 08 Aug 2013 15:10:45 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Peter LaDow <petela@gocougs.wsu.edu>
Subject: Re: Failure to detect PCI card
References: <CAN8Q1Ed-YtD1L7e9TaJyELdcz5Rcfdi0mdwU_H6HAx0-3FJ4Lg@mail.gmail.com>
 <20130805202559.0086e806@crub>
 <CAN8Q1EfoLTDr-x0r82Ezpqak+R=QuL1o37_OVU3Q0=8zFfDMqA@mail.gmail.com>
 <52000ACA.1010606@ovro.caltech.edu>
 <CAN8Q1EecMBWb_wKVOGnBJ=CHZ9zQQDKjwN5ZD4DkP30+QRerPA@mail.gmail.com>
 <CAN8Q1EfWOedMFKtFQbTmmydnLoLe24=c3Fo1Ao3sTdDmuYBJqQ@mail.gmail.com>
 <520058E0.8080304@ovro.caltech.edu>
 <CAN8Q1EczGM+aQMPti+QdvUHHbsn=ARV7sKptXc5M7gvEFoDkKQ@mail.gmail.com>
In-Reply-To: <CAN8Q1EczGM+aQMPti+QdvUHHbsn=ARV7sKptXc5M7gvEFoDkKQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Pete,

> For those that are interested, we did figure out what was going on.
> Turns out that the clock buffer driving the PCI connector was, well,
> less than adequate.  With some cards, the load on the clock line was
> large enough that the clock was in horrible shape.  Fixing the clock
> line and the card that failed to be recognized started working.  For
> the other cards that worked, the load on the clock line was
> significantly less, but the clock was still marginal.
>
> Anyway, turned out to be a hardware issue.  Thanks to all that helped!

Thanks for posting that you solved the issue.

The old engineering debug mantra ran true; check the power, then
clocks, then debug :)

Cheers,
Dave
