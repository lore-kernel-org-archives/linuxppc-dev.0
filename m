Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 0EBE1B708C
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 Aug 2009 21:20:16 +1000 (EST)
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8A036DDD01
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2009 21:20:14 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7CBBAVC007286
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2009 05:11:10 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7CBK0LB212004
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2009 05:20:00 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7CBJwrf012647
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2009 05:20:00 -0600
Date: Wed, 12 Aug 2009 07:19:54 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ARM clock API to PowerPC
Message-ID: <20090812111954.GB31596@zod.rchland.ibm.com>
References: <1250063825.15143.43.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1250063825.15143.43.camel@pasglop>
Cc: John Jacques <john.jacques@lsi.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss@lists.ozlabs.org, Torez Smith <torez@us.ibm.com>,
	Russell King <rmk@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 12, 2009 at 05:57:05PM +1000, Benjamin Herrenschmidt wrote:
>Hi folks !
>
>(Russell, let us know if you want to dropped from the CC list, but I
>felt you may have some useful input to provide here).
>
>So I think it would be valuable to provide the ARM clock API exposed by
>include/linux/clk.h on various PowerPC embedded hardware.

I'm probably being particularly dense, and I haven't had my coffee yet this
morning, but you never actually said _why_ you think this is valuable?

I'm a bit confused as to what problem you are trying to solve with the API.

josh
