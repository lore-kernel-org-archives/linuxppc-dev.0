Return-Path: <glikely@secretlab.ca>
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by ozlabs.org (Postfix) with ESMTP id 82138B7D9A
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jun 2010 09:36:25 +1000 (EST)
Received: by gwb11 with SMTP id 11so363521gwb.15
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jun 2010 16:36:23 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1276152002.1962.55.camel@pasglop>
References: <20100604212134.10552.70717.stgit@angua>
	<20100604212155.10552.19260.stgit@angua>
	<1276152002.1962.55.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 10 Jun 2010 17:36:01 -0600
Message-ID: <AANLkTinmDFBvAjcjrgf3RHuiXgNxVV20yLzBaqhE5lrk@mail.gmail.com>
Subject: Re: [PATCH 5/5] of/irq: merge of_irq_map_one()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Michal Simek <monstr@monstr.eu>,
	microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 10, 2010 at 12:40 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Fri, 2010-06-04 at 15:21 -0600, Grant Likely wrote:
>> Merge common implementation of of_irq_map_one(). =A0Rename it to
>> __of_irq_map_one() so that arch code can either use the stock
>> implementation, or override it to handle platform quirks.
>
> Similar comment to before, I think the breakup of functions causes more
> complication and bloat than just keeping the quirks in the generic code.

Okay.  I had been trying to avoid #ifdefs in the common code, but
you're probably right.  I'll rework.

g.
