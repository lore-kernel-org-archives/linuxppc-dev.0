Return-Path: <seanm@seanm.ca>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id D40B0DDF46
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 08:07:19 +1000 (EST)
Date: Mon, 28 Apr 2008 18:07:17 -0400
From: Sean MacLennan <seanm@seanm.ca>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [RESEND][PATCH][POWERPC] PIKA Warp: Update platform code to
	supportRev B boards
Message-ID: <20080428180717.4e06187a@lappy.seanm.ca>
In-Reply-To: <20080428215424.GA15973@ld0162-tx32.am.freescale.net>
References: <20080417152251.2bf07219@lappy.seanm.ca>
	<20080428145310.553b8271@lappy.seanm.ca>
	<fa686aa40804281256y722d8cf6pcae462d68b04e01f@mail.gmail.com>
	<20080428173738.6b1a2896@lappy.seanm.ca>
	<20080428215424.GA15973@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 28 Apr 2008 16:54:24 -0500
Scott Wood <scottwood@freescale.com> wrote:

> Why can't the existing partition binding be used with NAND?  It's
> what we do with Freescale FCM NAND.

I guess I could put the partitions in the dts. But I would have to
read them and dynamically create an array to pass to the ndfc driver.

It seems simpler to just statically initialize the array. Once the ndfc
is modified to use the dts, I will switch to that method.

Cheers,
   Sean
