Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 49429DE359
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 00:08:11 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m69E855x007130
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jul 2008 10:08:05 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m69E81VG016596
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jul 2008 08:08:04 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m69E81pw015427
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jul 2008 08:08:01 -0600
Date: Wed, 9 Jul 2008 10:00:23 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [RFC/PATCH] powerpc/bootwrapper: Allow user to specify
	additional default targets
Message-ID: <20080709100023.71eb739e@zod.rchland.ibm.com>
In-Reply-To: <fa686aa40807070729w524aa50xb1c762f13ba31da1@mail.gmail.com>
References: <20080701175852.32575.39707.stgit@trillian.secretlab.ca>
	<fa686aa40807032351l631febe2h8d38a9eed1053b6b@mail.gmail.com>
	<20080707091818.72d584fe@zod.rchland.ibm.com>
	<fa686aa40807070634t6e9047d1k7d8ca2b443d1ae68@mail.gmail.com>
	<20080707100704.26f1630c@zod.rchland.ibm.com>
	<fa686aa40807070729w524aa50xb1c762f13ba31da1@mail.gmail.com>
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

On Mon, 7 Jul 2008 08:29:47 -0600
"Grant Likely" <grant.likely@secretlab.ca> wrote:

> On Mon, Jul 7, 2008 at 8:07 AM, Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
> > On Mon, 7 Jul 2008 07:34:23 -0600 Grant Likely wrote:
> >> Specifically the case I'm thinking of is when a user of a Xilinx FPGA
> >> drops a new .dts file into arch/powerpc/boot/dts (say
> >> 'super-sexy-platform.dts').  However, instead of modifying the
> >> Makefile or always typing 'make simpleImage.super-sexy-platform', then
> >> can add 'simpleImage.super-sexy-platform' to their defconfig which I
> >> can see being easier for someone to get their head around.
> >
> > Yeah, I thought about the Virtex case with the differing bitstreams
> > after I sent out my original question.  For purposes like that, this
> > seems like a great fit.  For truly discrete boards, I prefer discrete
> > defconfigs.
> >
> > So overall I see value in the patch.  If nobody else has objections,
> > then it's fine with me.
> 
> so.... can I have an ack?  :-)

Oops, sorry.  Of course.

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

josh
