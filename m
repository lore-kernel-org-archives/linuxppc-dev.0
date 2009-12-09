Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9803EB6EEB
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Dec 2009 02:47:47 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nB9FZA32025438
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Dec 2009 08:35:10 -0700
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id nB9FlWQ9118554
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Dec 2009 08:47:34 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nB9FlWtV002785
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Dec 2009 08:47:32 -0700
Date: Wed, 9 Dec 2009 10:47:29 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH] powerpc: Increase warp SD buffer
Message-ID: <20091209154729.GT2937@zod.rchland.ibm.com>
References: <20091209000437.78794a8f@opus.seanm.ca>
	<20091209144055.GS2937@zod.rchland.ibm.com>
	<20091209103645.01058e79@opus.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091209103645.01058e79@opus.seanm.ca>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 09, 2009 at 10:36:45AM -0500, Sean MacLennan wrote:
>On Wed, 9 Dec 2009 09:40:55 -0500
>Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
>
>> How does that impact the older revisions?  You're using a cuImage
>> with Warp, so the device tree is bundled with that.  If you boot a
>> new kernel with this change to the DTS on a older board revision,
>> will it do bad things?
>
>The new SD driver takes care of that. If you use the new kernel with an
>old FPGA you reserve more space than you need, but the driver will not
>touch it.
>
>And if you somehow end up with the new DTS on an older kernel, the old
>SD driver will not use the space anyway since the buffer is limited to
>one block.
>
>The SD driver is not in the kernel proper because it was implemented in
>the FPGA and has a non-standard interface. It requires a change to the
>SD core to run. But it is GPLed, so if anybody wants to see it, just
>ask.

OK thanks.  I figured something like that would be the case, but wanted to
verify first.

josh
