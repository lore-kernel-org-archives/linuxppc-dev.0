Return-Path: <bwarren@qstreams.com>
Received: from smtp106.biz.mail.re2.yahoo.com (smtp106.biz.mail.re2.yahoo.com
	[206.190.52.175]) by ozlabs.org (Postfix) with SMTP id 1FBC567B6F
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Dec 2006 02:47:18 +1100 (EST)
Subject: Re: Compact Flash help
From: Ben Warren <bwarren@qstreams.com>
To: "s.balamurugan" <s.balamurugan@gdatech.co.in>
In-Reply-To: <456EA445.70504@gdatech.co.in>
References: <456EA445.70504@gdatech.co.in>
Content-Type: text/plain
Date: Thu, 30 Nov 2006 10:40:37 -0500
Message-Id: <1164901237.31193.116.camel@saruman.qstreams.net>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: bwarren@qstreams.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Bala,

On Thu, 2006-11-30 at 14:58 +0530, s.balamurugan wrote:
> Hello all,
> 
>                     This is bala, I am using MPC8360  board and compact 
> flash is connected via Local Bus Controller(UPM).
> I have the following questions
> what are the necessary document to be read for writting the driver for 
> compact flash.
> What is the relation between compact flash and PCMCIA and PC Card.
> What are the CIS structure members.
> What are the documents to be read to understand the full concept of 
> Compact Flash.

If you're REALLY interested in knowing everything about Compact Flash,
go here: http://www.compactflash.org/  You can download the spec, which
should help you sleep.

If you want to know how to interface Compact Flash to your Local Bus,
here's a good document.  I'm not intimately familiar with the 8360, but
unless Freescale has changed their LBC design, it should apply:
http://www.toshiba.com/taec/components/ApplNote/TSB_CF-Motorola_PPC8260_030325.pdf

You shouldn't have to write your own driver for this.  I don't feel
totally comfortable giving you somebody else's code that isn't
necessarily finished, but since you could Google it yourself anyway,
here's a link to one that was put up for comment several months ago.  I
had no part in authoring it and have no idea where it stands regarding
inclusion in the kernel, so please treat it as experimental.  It will
require a bit of work on your part to understand how to specify platform
devices. 

http://lkml.org/lkml/2006/2/1/47

regards,
Ben
