Return-Path: <flar@cynthia.pants.nu>
Received: from cynthia.pants.nu (adsl-76-245-85-235.dsl.pltn13.sbcglobal.net
	[76.245.85.235]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C0651DE014
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Apr 2008 06:36:15 +1100 (EST)
Date: Fri, 4 Apr 2008 10:20:06 -0700
From: Brad Boyer <flar@allandria.com>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH/RFC] via-pmu: remove mdelays from suspend/resume code
Message-ID: <20080404172006.GA13980@cynthia.pants.nu>
References: <1207237484.3797.2.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1207237484.3797.2.camel@johannes.berg>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 03, 2008 at 05:44:44PM +0200, Johannes Berg wrote:
> I don't see a reason for either of those mdelay()s, is there any? Works
> fine for me without them...

Which hardware revisions did you test? I suspect the mdelay calls were
added to work around timing issues in one of the older PMU chips. Some
of them are very timing sensitive, and sleep in particular is basically
a pile of steps that got hacked until they worked on older systems.

	Brad Boyer
	flar@allandria.com
