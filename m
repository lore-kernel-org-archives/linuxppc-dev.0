Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B2E15DDE24
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 14:16:45 +1100 (EST)
Message-ID: <45FB5D5F.10106@am.sony.com>
Date: Fri, 16 Mar 2007 20:15:43 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>, "Mark A. Greer" <mgreer@mvista.com>,
	linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 8/15] zImage: Cleanup and improve zImage entry point
References: <20070305032307.GB31417@localhost.localdomain>	<20070305032452.810C1DDF1B@ozlabs.org>	<20070315230230.GB3342@mag.az.mvista.com>	<20070316001819.GE6784@localhost.localdomain>	<20070316004717.GB10786@mag.az.mvista.com>	<20070316005016.GI6784@localhost.localdomain>	<20070316162135.GA29231@ld0162-tx32.am.freescale.net>
	<20070317013859.GJ3969@localhost.localdomain>
In-Reply-To: <20070317013859.GJ3969@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Fri, Mar 16, 2007 at 11:21:35AM -0500, Scott Wood wrote:
>> One problem with that is that the wrapper currently only accepts one
>> platform .o file -- and presumably one isn't going to want to do all of
>> the platform code in assembly.
> 
> Um.. nobody does it yet, but I don't think there's actually any reason
> that $platformo can't be set to a list of multiple .o files.

I have it setup like this, from a mix of .c and .S sources:

+ps3)
+    platformo="$object/head_64.o $object/smp.o $object/ps3-hvcall.o $object/ps3.o"

-Geoff
