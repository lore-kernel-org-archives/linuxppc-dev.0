Return-Path: <B04825@freescale.com>
Received: from DB3EHSOBE002.bigfish.com (db3ehsobe002.messaging.microsoft.com
	[213.199.154.140])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CB4A4B6F75
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jul 2011 03:54:32 +1000 (EST)
Message-ID: <4E1B38CF.2050408@freescale.com>
Date: Mon, 11 Jul 2011 12:54:23 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: RFC: top level compatibles for virtual platforms
References: <9F6FE96B71CF29479FF1CDC8046E150316EAB6@039-SN1MPN1-003.039d.mgd.msft.net>	<CAOZdJXVp5LHqYEMoqpnKEkuWyuE6kwU+Z9VwUYLPcz-+h_gqfw@mail.gmail.com>	<9F6FE96B71CF29479FF1CDC8046E150316F97F@039-SN1MPN1-003.039d.mgd.msft.net>	<4E1B1AAB.8010301@freescale.com>
	<20110711112418.4db9f41e@schlenkerla.am.freescale.net>
In-Reply-To: <20110711112418.4db9f41e@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Alexander Graf <agraf@suse.de>, Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood wrote:
> The device tree is supposed to describe the hardware (virtual or
> otherwise), not just supply what Linux wants.  Perhaps there simply
> shouldn't be a toplevel compatible if there's nothing appropriate to
> describe there -- and fix whatever issues Linux has with that.

That might be the way to go.  I wonder if we can get rid of the platform file
altogether, at least in some situations.

> But what about this is specific to kvm (the actual hypervisor info is
> already described in /hypervisor)?  Then we'll have to add a platform match
> for every other hypervisor out there that does the same thing.

I don't know enough about KVM to answer that question.

Frankly, I like the approach that Topaz takes -- add a "-hv" to the real
hardware platform.  The only drawback is that each platform needs to add support
for virtualization, but we already have this problem with Topaz today.

-- 
Timur Tabi
Linux kernel developer at Freescale
