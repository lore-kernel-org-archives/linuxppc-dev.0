Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EC74EDDDCA
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 12:15:30 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n0L1E9px003510
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jan 2009 18:14:09 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n0L1FRp2203366
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jan 2009 18:15:27 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n0L1FRG6029128
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jan 2009 18:15:27 -0700
Date: Tue, 20 Jan 2009 20:15:11 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: Defconfig support
Message-ID: <20090121011511.GH3853@zod.rchland.ibm.com>
References: <20090119232136.717eddf3@lappy.seanm.ca>
	<20090120112930.GF3853@zod.rchland.ibm.com>
	<20090120200936.1cdc91b4@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090120200936.1cdc91b4@lappy.seanm.ca>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 20, 2009 at 08:09:36PM -0500, Sean MacLennan wrote:
>On Tue, 20 Jan 2009 06:29:30 -0500
>"Josh Boyer" <jwboyer@linux.vnet.ibm.com> wrote:
>
>> Since I'll be doing defconfig updates today, just tell me which
>> options you need set or disabled.
>
>Let's try this patch and see how it goes. If it doesn't apply easily, I
>will just give you a list. 
>
>Note a few of the options will be disabled with the make oldconfig and
>that is fine.
>
>The ones I know will be disabled are the PIKA_SD driver and the
>PIKA_LEDS driver. Also I don't think it will let you disabled
>SCSI_WAIT_SCAN :( You have to patch a Kconfig for that.

OK, I'll work these in tonight and then send them Ben's way.

josh
