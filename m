Return-Path: <jonmasters@gmail.com>
Received: from mproxy.gmail.com (rproxy.gmail.com [64.233.170.195])
	by ozlabs.org (Postfix) with ESMTP id CA7C02BD9F
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Oct 2004 08:14:22 +1000 (EST)
Received: by mproxy.gmail.com with SMTP id 76so308413rnk
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Oct 2004 15:14:09 -0700 (PDT)
Message-ID: <35fb2e59041011151463b2a4bf@mail.gmail.com>
Date: Mon, 11 Oct 2004 23:14:09 +0100
From: Jon Masters <jonmasters@gmail.com>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <547E0D34-1BB5-11D9-909B-003065F9B7DC@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <1097515329.8508.66.camel@nighteyes.localdomain>
	<547E0D34-1BB5-11D9-909B-003065F9B7DC@embeddededge.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Jeff Angielski <jangiels@speakeasy.net>, linuxppc-embedded@ozlabs.org
Subject: Re: Creating rootfs
Reply-To: jonathan@jonmasters.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 11 Oct 2004 14:42:40 -0400, Dan Malek <dan@embeddededge.com> wrote:
> 
> On Oct 11, 2004, at 1:22 PM, Jeff Angielski wrote:
> 
> > So how are people creating the rootfs for their embedded target these
> > days?  Busybox?  PTX?  Strip down some existing filesystem?

[ This wants to go to linuxppc-embedded from now on. ]

I use PTXdist but with a crosstool generated toolchain at the moment.
I then package up stuff that isn't in PTXdist - but you could
experiment with embedded Debian et al.

> Those are the solutions, choose whatever works best for you.

There's a whole bunch of distributions out there too. However rolling
your own is the best bet for a small filesystem if you're not buying
commercial tools at this point. Otherwise, go pay Monta, DENX, or one
of the other embedded developer supporting companies for a flashy
solution.

Jon.
