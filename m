Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
 by ozlabs.org (Postfix) with ESMTP id 36C972C0077
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2013 07:10:47 +1000 (EST)
Message-ID: <520014C5.4060703@ovro.caltech.edu>
Date: Mon, 05 Aug 2013 14:10:29 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Peter LaDow <petela@gocougs.wsu.edu>
Subject: Re: Failure to detect PCI card
References: <CAN8Q1Ed-YtD1L7e9TaJyELdcz5Rcfdi0mdwU_H6HAx0-3FJ4Lg@mail.gmail.com>
 <20130805202559.0086e806@crub>
 <CAN8Q1EfoLTDr-x0r82Ezpqak+R=QuL1o37_OVU3Q0=8zFfDMqA@mail.gmail.com>
 <52000ACA.1010606@ovro.caltech.edu>
 <CAN8Q1EcnT3We1X22pw4AQ28xmd2d-XB9nTzZ2KdVb=qOx4j7-Q@mail.gmail.com>
 <5200143F.9010307@ovro.caltech.edu>
In-Reply-To: <5200143F.9010307@ovro.caltech.edu>
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


> Actually, before going down that route, I would get a PCI extender
> that you can use to trace the traffic with your board. Does the
> network card use 33MHz or 66MHz?

I wonder if something like this board:

http://www.logicsupply.com/products/pci122_dflex

can be used to make a single PCI slot into two PCI slots. You
could then plug your analyzer into the second slot.

For $30 it might be worth a shot ...

Cheers,
Dave
