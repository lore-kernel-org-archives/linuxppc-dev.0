Return-Path: <SRS0=2/sND6=HW=cogcomp.com=mike@yourhostingaccount.com>
Received: from mailout07.yourhostingaccount.com
	(mailout07.yourhostingaccount.com [65.254.253.56])
	by ozlabs.org (Postfix) with ESMTP id 4FF04DDEEC
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 12:48:54 +1100 (EST)
Received: from mailscan28.yourhostingaccount.com ([10.1.15.28]
	helo=mailscan28.yourhostingaccount.com)
	by mailout07.yourhostingaccount.com with esmtp (Exim)
	id 1HH9GO-0001f8-Ex
	for linuxppc-dev@ozlabs.org; Tue, 13 Feb 2007 20:48:52 -0500
Received: from authsmtp11.yourhostingaccount.com ([10.1.18.11] ident=exim)
	by mailscan28.yourhostingaccount.com with spamscanlookuphost (Exim)
	id 1HH9GO-0001xo-7n
	for linuxppc-dev@ozlabs.org; Tue, 13 Feb 2007 20:48:52 -0500
Message-Id: <6.2.5.6.2.20070213202913.03e23eb0@cogcomp.com>
Date: Tue, 13 Feb 2007 20:39:15 -0500
To: Kumar Gala <galak@kernel.crashing.org>
From: Michael Kelly <mike@cogcomp.com>
Subject: Re: USB Host controller for MPC8548e board
In-Reply-To: <C7F96CD5-4CB7-48E3-ABF5-17E1685AAC24@kernel.crashing.org>
References: <6.2.5.6.2.20070213191530.03e27eb0@cogcomp.com>
	<C7F96CD5-4CB7-48E3-ABF5-17E1685AAC24@kernel.crashing.org>
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

The reason I asked here is that they are in the kernel and seem to be 
as well supported.  I was
just more concerned if there were any PowerPC specific issues.  We 
are likely going ahead
with the NEC (since that is what was used on the G5 MAC's, I think), 
and we'll find out just how
well they work!  That's what prototypes are for.

Thanks,
Michael

At 08:19 PM 2/13/2007, Kumar Gala wrote:

>On Feb 13, 2007, at 6:21 PM, Michael Kelly wrote:
>
>>Hello all.  We are in the process of designing an MPC8548e board.  We
>>wish to add
>>USB host via either the NXP ISP1561 or NEC upd720101.  They are
>>both OHCI and
>>EHCI.
>
>Haven't worked with either of this, you're probably better asking
>about this on the linux-usb list.
>
>>Is there any general advice on one over the other or even if it is
>>realistic to have a USB
>>host controller on a big endian processor?
>
>There shouldn't be any issue with having a USB controller on a big- 
>endian processor.
>
>If your connecting them over PCI it should pretty easy to get them up
>and running.
>
>- k
>
>

Michael J. Kelly
VP Engineering
Cogent Computer Systems, Inc.
17 Industrial Dr.
Smithfield, RI 02917 USA
tel: 401-223-3441, fax: 401-223-3442
email: mike@cogcomp.com
alternate email: mkelly6505@hotmail.com
web: www.cogcomp.com
