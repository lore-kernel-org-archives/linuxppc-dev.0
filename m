Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BEC7CDDFF2
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jan 2009 22:29:49 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n0KBSjMG025954
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jan 2009 04:28:45 -0700
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n0KBTkH8225408
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jan 2009 04:29:46 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n0KBTjIW027708
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jan 2009 04:29:45 -0700
Date: Tue, 20 Jan 2009 06:29:30 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: Defconfig support
Message-ID: <20090120112930.GF3853@zod.rchland.ibm.com>
References: <20090119232136.717eddf3@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090119232136.717eddf3@lappy.seanm.ca>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 19, 2009 at 11:21:36PM -0500, Sean MacLennan wrote:
>Since the list seems quiet right now, thought I would ask a question.
>Up till now I haven't really worried about the warp defconfig being up
>to date since, realistically, the stock kernel was not usable on the
>warp. Since it usually boots from NAND, the lack of an ndfc driver
>made it unbootable in a production system.
>
>However, the 2.6.29 kernel will boot, so the defconfig problem becomes
>more acute. The problem is keeping the changes that are required for
>the warp while also handling the normal changes that happen every
>release.
>
>For example, the current git diff shows CONFIG_SIMPLE_GPIO which is
>just a new feature and can be safely left unset. But the watchdog made
>it into the kernel, so CONFIG_PIKA_WDT should be set for a warp.
>
>Any ideas for a good way of handling this?

You can certainly send me patches for defconfig updates.  I go through
and update them all (via make xxx_defconfig; make oldconfig) after -rc2
is available, but I might not set everything exactly as you would want
to see it.

If there's a chicken/egg problem in that there are drivers or changes
that went upstream but aren't in the powerpc branches yet for one reason
or another, you can poke me about getting things pulled in.

Since I'll be doing defconfig updates today, just tell me which options
you need set or disabled.

josh
