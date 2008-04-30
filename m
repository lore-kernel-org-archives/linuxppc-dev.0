Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CF0C5DDDFA
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 10:54:44 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m3U0sa5D020673
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 20:54:36 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m3U0sa1v193756
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 18:54:36 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m3U0saj6032661
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 18:54:36 -0600
Date: Tue, 29 Apr 2008 19:48:06 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Sean MacLennan <seanm@seanm.ca>
Subject: Re: [RESEND][PATCH][POWERPC] PIKA Warp: Update platform code to
	supportRev B boards
Message-ID: <20080429194806.54c2535b@zod.rchland.ibm.com>
In-Reply-To: <20080428180717.4e06187a@lappy.seanm.ca>
References: <20080417152251.2bf07219@lappy.seanm.ca>
	<20080428145310.553b8271@lappy.seanm.ca>
	<fa686aa40804281256y722d8cf6pcae462d68b04e01f@mail.gmail.com>
	<20080428173738.6b1a2896@lappy.seanm.ca>
	<20080428215424.GA15973@ld0162-tx32.am.freescale.net>
	<20080428180717.4e06187a@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 28 Apr 2008 18:07:17 -0400
Sean MacLennan <seanm@seanm.ca> wrote:

> On Mon, 28 Apr 2008 16:54:24 -0500
> Scott Wood <scottwood@freescale.com> wrote:
> 
> > Why can't the existing partition binding be used with NAND?  It's
> > what we do with Freescale FCM NAND.
> 
> I guess I could put the partitions in the dts. But I would have to
> read them and dynamically create an array to pass to the ndfc driver.
> 
> It seems simpler to just statically initialize the array. Once the ndfc
> is modified to use the dts, I will switch to that method.

Right.  It's a limitation of NDFC, which isn't WARP specific and needs
fixing in general.

josh
