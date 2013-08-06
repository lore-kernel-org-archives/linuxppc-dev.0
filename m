Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 877D02C00BE
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 06:03:33 +1000 (EST)
Date: Tue, 6 Aug 2013 22:03:23 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Peter LaDow <petela@gocougs.wsu.edu>
Subject: Re: Failure to detect PCI card
Message-ID: <20130806220323.09f88389@crub>
In-Reply-To: <CAN8Q1EfWOedMFKtFQbTmmydnLoLe24=c3Fo1Ao3sTdDmuYBJqQ@mail.gmail.com>
References: <CAN8Q1Ed-YtD1L7e9TaJyELdcz5Rcfdi0mdwU_H6HAx0-3FJ4Lg@mail.gmail.com>
 <20130805202559.0086e806@crub>
 <CAN8Q1EfoLTDr-x0r82Ezpqak+R=QuL1o37_OVU3Q0=8zFfDMqA@mail.gmail.com>
 <52000ACA.1010606@ovro.caltech.edu>
 <CAN8Q1EecMBWb_wKVOGnBJ=CHZ9zQQDKjwN5ZD4DkP30+QRerPA@mail.gmail.com>
 <CAN8Q1EfWOedMFKtFQbTmmydnLoLe24=c3Fo1Ao3sTdDmuYBJqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, David Hawkins <dwh@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 5 Aug 2013 16:14:29 -0700
Peter LaDow <petela@gocougs.wsu.edu> wrote:
...
> Perhaps it is a BIOS option ROM like you suggested earlier.  The
> 3c90xC reference manual I found
> (http://people.freebsd.org/~wpaul/3Com/3c90xc.pdf) mentions an option
> ROM (and there is an Atmel part stuffed).  I can't find any technical
> information on the FA331 (yet), so I don't know about it.
> 
> But regardless, wouldn't enumeration have to occur before any option
> ROM could even be used?

Yes. If the device didn't respond with its Device- and Vendor-ID
when reading its configuration space, then it cannot be configured
and reading the expansion ROM won't work.

Thanks,

Anatolij
