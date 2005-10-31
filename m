Return-Path: <markc@mail.com>
Received: from relay01.roc.ny.frontiernet.net (relay01.roc.ny.frontiernet.net
	[66.133.182.164]) by ozlabs.org (Postfix) with ESMTP id 601AE68604
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Oct 2005 23:55:21 +1100 (EST)
Message-ID: <003501c5de1a$be79b390$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "David Jander" <david.jander@protonic.nl>, <linuxppc-embedded@ozlabs.org>
References: <200510280857.44625.david.jander@protonic.nl><20051028153059.GC18915@logos.cnet>
	<200510310921.34696.david.jander@protonic.nl>
Date: Mon, 31 Oct 2005 07:58:03 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: Kernel 2.6 on MPC8xx performance trouble...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>
> I have made another test in the meantime, trying to check if cache is
working.
> <snip>
> No, sir, no cache detected !
>
> Where do I have to look now?
>

Could the cache be in writethrough mode? (Instead of writeback)

Mark Chambers
