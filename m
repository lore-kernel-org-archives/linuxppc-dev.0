Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 301FFDDDF6
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Mar 2009 08:05:39 +1100 (EST)
Subject: Re: OF device mappings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gary Thomas <gary@mlbassoc.com>
In-Reply-To: <49A98DFF.9050503@mlbassoc.com>
References: <49A97878.6060308@mlbassoc.com>
	<fa686aa40902281004r5fcb67f4md328d79dd1d5d82c@mail.gmail.com>
	<49A9809D.9000307@mlbassoc.com>
	<fa686aa40902281044l3b910866g7467131db80c87e7@mail.gmail.com>
	<49A98DFF.9050503@mlbassoc.com>
Content-Type: text/plain
Date: Sun, 01 Mar 2009 08:05:32 +1100
Message-Id: <1235855132.7388.112.camel@pasglop>
Mime-Version: 1.0
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2009-02-28 at 12:18 -0700, Gary Thomas wrote:
> Grant Likely wrote:
> > On Sat, Feb 28, 2009 at 11:21 AM, Gary Thomas <gary@mlbassoc.com> wrote:
> >> Grant Likely wrote:
> >>> Once you have a handle to the node, you can iterate through the
> >>> of_platform bus devices and look for a node which has a matching node
> >>> pointer stored in archdata.  That will give you a struct device which
> >>> is contained by a struct of_device (note well: this will give you an
> >>> of_device, not a platform_device.)
> >> I have code which does this already, but I could not figure out
> >> how to get from the of_device node to the actual platform_device.

 .../...

You may want to look how I do something similar in
drivers/net/ibm_newemac

Not necessarily the nicest approach but works for now, until we have
something better.

Cheers,
Ben.
