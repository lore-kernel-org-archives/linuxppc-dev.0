Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 42430DE0ED
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 03:35:02 +1000 (EST)
Date: Mon, 15 Oct 2007 12:40:59 -0500
From: Olof Johansson <olof@lixom.net>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Refactor booting-without-of.txt
Message-ID: <20071015174059.GA17387@lixom.net>
References: <fa686aa40710150908o55d1f5d2t264cbb8ed800a12f@mail.gmail.com>
	<20071015165505.GA16040@lixom.net>
	<fa686aa40710151014q5e151ea9w3f589d9e89e95905@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40710151014q5e151ea9w3f589d9e89e95905@mail.gmail.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, microblaze-uclinux@itee.uq.edu.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Mon, Oct 15, 2007 at 11:14:44AM -0600, Grant Likely wrote:
> On 10/15/07, Olof Johansson <olof@lixom.net> wrote:
> >
> > The flat device tree is, in spite of what some people would like it to be,
> > not open firmware, nor is it the same as their bindings. So I think we'd
> > be doing ourselves a disservice by continuing to associate them together.
> > All it would take is a rename of the directory, unfortunately i don't
> > have any suggestions on better names though.
> 
> I think I need to stick with the of prefix.  All the support API in
> include/linux/of_* is prefixed with "of_" already, so convention is
> established.
> 
> How about Documentation/of-device-tree?

Sounds good to me, even though it doesn't really address the original
OF separation comment. :)

Maybe it's enough to document the difference between the linux-specific
flat device tree bindings and classic 1275-style bindings in the top
readme in that directory. Either way, it's not worth arguing over,
your suggestion is good enough.

> > Looks reasonable. The other way to cut it would be to slice along vendor
> > boundaries, but I think I like the functional partitioning you suggested
> > better.
> 
> I think vendor partitioning makes sense for non-common devices that
> don't easily fit into a particular mold (soc glue nodes come to mind).
>  Other than that, the functional partitioning
> lets us start with defining common property usage for a given device
> type and follow up with device specific properties.

Yep, it could always be added down the road in case it's needed.


-Olof
