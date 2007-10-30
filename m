Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by ozlabs.org (Postfix) with ESMTP id 2FEFBDE11B
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 16:58:29 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2573717wag
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Oct 2007 22:58:23 -0700 (PDT)
Message-ID: <fa686aa40710292258w104a84d0t17b9ff0f0efc9685@mail.gmail.com>
Date: Mon, 29 Oct 2007 23:58:22 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Grant Likely" <grant.likely@secretlab.ca>,
	"Marian Balakowicz" <m8@semihalf.com>, linuxppc-dev@ozlabs.org,
	"Martin Krause" <Martin.Krause@tqs.de>
Subject: Re: [PATCH 05/11] [POWERPC] TQM5200 DTS
In-Reply-To: <20071030005833.GI29263@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071023231302.29359.27417.stgit@hekate.izotz.org>
	<20071023231333.29359.35252.stgit@hekate.izotz.org>
	<13403420.post@talk.nabble.com>
	<fa686aa40710250653o6e7df26y1890d5c485a6d508@mail.gmail.com>
	<4720BA4B.5090707@semihalf.com>
	<20071026013343.GD457@localhost.localdomain>
	<4725EB9E.1030507@semihalf.com>
	<fa686aa40710290840w41e2ffeo38b9497ce76e155@mail.gmail.com>
	<20071030005833.GI29263@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/29/07, David Gibson <david@gibson.dropbear.id.au> wrote:
> On Mon, Oct 29, 2007 at 09:40:23AM -0600, Grant Likely wrote:
> > It's probably more appropriate to have the flash partition layout in
> > the u-boot environment and have u-boot populate the partition
> > information in the device tree.
>
> That sounds like a reasonable idea.
>
> But if the flash partition layout is *not* fixed - but selectable by
> the board installer, then it should certainly not be hardcoded into a
> fixed dts.

Exactly my point!  :-)

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
