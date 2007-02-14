Return-Path: <SRS0=2/sND6=HW=cogcomp.com=mike@yourhostingaccount.com>
Received: from mailout15.yourhostingaccount.com
	(mailout15.yourhostingaccount.com [65.254.253.120])
	by ozlabs.org (Postfix) with ESMTP id 0258BDDF0F
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 13:17:11 +1100 (EST)
Received: from mailscan45.yourhostingaccount.com ([10.1.15.45]
	helo=mailscan45.yourhostingaccount.com)
	by mailout15.yourhostingaccount.com with esmtp (Exim)
	id 1HH9hm-0006gY-12
	for linuxppc-dev@ozlabs.org; Tue, 13 Feb 2007 21:17:10 -0500
Received: from authsmtp10.yourhostingaccount.com ([10.1.18.10] ident=exim)
	by mailscan45.yourhostingaccount.com with spamscanlookuphost (Exim)
	id 1HH9hm-00025Z-1o
	for linuxppc-dev@ozlabs.org; Tue, 13 Feb 2007 21:17:10 -0500
Message-Id: <6.2.5.6.2.20070213210830.03e29c80@cogcomp.com>
Date: Tue, 13 Feb 2007 21:09:16 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Kelly <mike@cogcomp.com>
Subject: Re: USB Host controller for MPC8548e board
In-Reply-To: <1171417704.20192.123.camel@localhost.localdomain>
References: <6.2.5.6.2.20070213191530.03e27eb0@cogcomp.com>
	<1171417704.20192.123.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: Michael Kelly <mike@cogcomp.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

They are PCI based, so that's good news!

Thanks, I'll let you know how it all works out.  I'm sure I'll be asking other
questions as we go along.

Michael


At 08:48 PM 2/13/2007, Benjamin Herrenschmidt wrote:
>On Tue, 2007-02-13 at 19:21 -0500, Michael Kelly wrote:
> > Hello all.  We are in the process of designing an MPC8548e board.  We
> > wish to add
> > USB host via either the NXP ISP1561 or NEC upd720101.  They are 
> both OHCI and
> > EHCI.
> >
> > Is there any general advice on one over the other or even if it is
> > realistic to have a USB
> > host controller on a big endian processor?
>
>Are they PCI based ? In this case they should pretty much work out of
>the box.
>
>Ben.

Michael J. Kelly
VP Engineering
Cogent Computer Systems, Inc.
17 Industrial Dr.
Smithfield, RI 02917 USA
tel: 401-223-3441, fax: 401-223-3442
email: mike@cogcomp.com
alternate email: mkelly6505@hotmail.com
web: www.cogcomp.com
