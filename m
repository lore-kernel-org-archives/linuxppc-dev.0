Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C307ADDF4B
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jul 2008 10:28:25 +1000 (EST)
Subject: RE: [PATCH 12/60] microblaze_v4: Generic dts file for platforms
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
In-Reply-To: <20080701155845.9DDE299004D@mail180-dub.bigfish.com>
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	<1214483429-32360-6-git-send-email-monstr@seznam.cz>
	<1214483429-32360-7-git-send-email-monstr@seznam.cz>
	<1214483429-32360-8-git-send-email-monstr@seznam.cz>
	<1214483429-32360-9-git-send-email-monstr@seznam.cz>
	<1214483429-32360-10-git-send-email-monstr@seznam.cz>
	<1214483429-32360-11-git-send-email-monstr@seznam.cz>
	<1214483429-32360-12-git-send-email-monstr@seznam.cz>
	<1214483429-32360-13-git-send-email-monstr@seznam.cz>
	<fa686aa40806272249l7eae0c34k43a20ad41672b77a@mail.gmail.com>
	<1d3f23370806291702g4344a2f9lb62f85cbb475fca4@mail.gmail.com>
	<20080630033943.332471860046@mail171-va3.bigfish.com>
	<1214893302.20711.102.camel@pasglop>
	<20080701155845.9DDE299004D@mail180-dub.bigfish.com>
Content-Type: text/plain
Date: Wed, 02 Jul 2008 10:25:30 +1000
Message-Id: <1214958330.20711.205.camel@pasglop>
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	Michal Simek <monstr@monstr.eu>, vapier.adi@gmail.com,
	arnd@arndb.de, matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	will.newton@gmail.com, hpa@zytor.com,
	John Linn <linnj@xilinx.com>, monstr@seznam.cz,
	drepper@redhat.com, John Williams <john.williams@petalogix.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-07-01 at 08:58 -0700, Stephen Neuendorffer wrote:
> Doing this at the binary level would be nice, but I see enough problems
> just doing it at the source level and at least for my purposes, doing it
> on a dtb would be overkill, I think.   
> 
> The main difficulty remains how to deal with cross references between
> nodes in a reasonable way where the references cross from one fragment
> to another.

I would have those done in the toplevel .dts

You can always override the property with the reference....

Ie. you #include your CPU or your SOC for example, and then override
some property to point to something else using the override mechanism I
mentioned.

Ben.
