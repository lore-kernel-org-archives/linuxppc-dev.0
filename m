Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8B9D5DDF1D
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 11:05:28 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4G12AgU019022
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 21:02:10 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4G15O6a112068
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 19:05:24 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4G15OY8025176
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 19:05:24 -0600
Date: Thu, 15 May 2008 20:02:07 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Convert remaining dts-v0 files to v1
Message-ID: <20080515200207.5102d770@zod.rchland.ibm.com>
In-Reply-To: <18476.56005.520095.757098@cargo.ozlabs.ibm.com>
References: <20080515064639.GB30996@yookeroo.seuss>
	<482C9B6F.1020907@am.sony.com>
	<20080515181715.06dd124f@zod.rchland.ibm.com>
	<18476.56005.520095.757098@cargo.ozlabs.ibm.com>
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

On Fri, 16 May 2008 10:52:21 +1000
Paul Mackerras <paulus@samba.org> wrote:

> Josh Boyer writes:
> 
> > Since this mostly effects DTSs for my boards, do you mind if I pull
> > this into my tree?  I spoke with Geoff today and he doesn't have any
> > planned PS3 DTS updates, so we shouldn't get conflicts doing it that
> > way.
> 
> Sounds fine.  Is this for 2.6.26?  Do you have some 2.6.26 updates
> queued up for me (or will you)?

No, this is .27 work.  Which is why I figured it would be easier if I
grabbed it for now.

The only possible .26 candidate I have at the moment would be the
CHIP_11 errata workaround patch I sent out earlier today.  I need to do
more testing across a wider variety of boards and that I was planning
on having you pull that from me.

josh
