Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9B527DDD0D
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Nov 2007 00:02:16 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9VD28nc032332
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 09:02:08 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9VD28uu094020
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 07:02:08 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9VD28uO019453
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 07:02:08 -0600
Date: Wed, 31 Oct 2007 07:59:19 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH 0/4] PowerPC: 440GRx Rainier board support.
Message-ID: <20071031075919.16a4ed14@zod.rchland.ibm.com>
In-Reply-To: <47287339.6040404@ru.mvista.com>
References: <20071030164511.GA21973@ru.mvista.com>
	<20071030151608.28a2d706@weaponx.rchland.ibm.com>
	<47287339.6040404@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 31 Oct 2007 15:21:13 +0300
Valentine Barshak <vbarshak@ru.mvista.com> wrote:

> Josh Boyer wrote:
> > On Tue, 30 Oct 2007 19:45:11 +0300
> > Valentine Barshak <vbarshak@ru.mvista.com> wrote:
> > 
> >> The following patches add PowerPC 440GRx Rainier board support.
> >> The board is almost identical to Sequoia, but doesn't have USB
> >> and FPU is not supported.
> > 
> > So why do we need anything other than the DTS and the defconfig?  I
> > would think the sequoia wrapper and platform files would suffice
> > completely for this.
> 
> Yes, they would, but how to handle the board name in this case?
> I mean the resulting image would be cuImage.sequoia for rainier and the 
> DTS board name has to be sequoia for rainier too.
> I don't now, may be it's not a big deal to call rainier a sequoia though.
> What do you think?

Let me think about this for a bit.  Theoretically, there should be a
way to have a common code base between these two boards and have the
images use the right names.

josh
