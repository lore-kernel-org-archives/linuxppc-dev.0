Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4A1F267B61
	for <linuxppc-dev@ozlabs.org>; Mon,  1 May 2006 19:35:23 +1000 (EST)
Subject: Re: [PATCH] via-pmu: report powerbutton as proper input event
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1146475314.24172.7.camel@localhost>
References: <1146251713.5019.4.camel@localhost>
	<1146466716.30710.39.camel@localhost.localdomain>
	<1146473774.24172.2.camel@localhost>
	<1146474566.30710.45.camel@localhost.localdomain>
	<1146475314.24172.7.camel@localhost>
Content-Type: text/plain
Date: Mon, 01 May 2006 19:35:16 +1000
Message-Id: <1146476116.30710.49.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-05-01 at 11:21 +0200, Johannes Berg wrote:
> On Mon, 2006-05-01 at 19:09 +1000, Benjamin Herrenschmidt wrote:
> > > What else does it report? As far as I know it doesn't have anything
> > > else, at least on my system.
> > 
> > Depends on the machine... earlier ones have the backlight there or
> > volume control.. then LID close could be an event too...
> 
> Ok, yea. Well, we need to rework all of that. Currently, to get at the
> lid status, you have to open /dev/adb and do something through that.
> 
> I honestly don't understand the reason for this. Is it just historic?

Yes.

Ben.
