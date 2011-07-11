Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AFAF9B6F54
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jul 2011 02:24:24 +1000 (EST)
Date: Mon, 11 Jul 2011 11:24:18 -0500
From: Scott Wood <scottwood@freescale.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: RFC: top level compatibles for virtual platforms
Message-ID: <20110711112418.4db9f41e@schlenkerla.am.freescale.net>
In-Reply-To: <4E1B1AAB.8010301@freescale.com>
References: <9F6FE96B71CF29479FF1CDC8046E150316EAB6@039-SN1MPN1-003.039d.mgd.msft.net>
	<CAOZdJXVp5LHqYEMoqpnKEkuWyuE6kwU+Z9VwUYLPcz-+h_gqfw@mail.gmail.com>
	<9F6FE96B71CF29479FF1CDC8046E150316F97F@039-SN1MPN1-003.039d.mgd.msft.net>
	<4E1B1AAB.8010301@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
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

On Mon, 11 Jul 2011 10:45:47 -0500
Timur Tabi <timur@freescale.com> wrote:

> >> Also, if these are KVM creations, shouldn't there be a "kvm" in the compatible string
> >> somewhere?
> > 
> > There is nothing KVM specific about these platforms.  Any hypervisor
> > could create a similar virtual machine.
> 
> True, but I think we're on a slippery slope, here.  Virtualization allows us to
> create "virtual platforms" that are not well defined.  Linux requires a unique
> compatible string for each platform.

The device tree is supposed to describe the hardware (virtual or
otherwise), not just supply what Linux wants.  Perhaps there simply
shouldn't be a toplevel compatible if there's nothing appropriate to
describe there -- and fix whatever issues Linux has with that.

> I guess my point is back to the name "corenet".  That just doesn't mean anything
> to me, and I don't think it means much to anyone else, either.  That's why I
> think that maybe "kvm" should be in the string, to at least indicate that it's a
> virtualized environment.

But what about this is specific to kvm (the actual hypervisor info is
already described in /hypervisor)?  Then we'll have to add a platform match
for every other hypervisor out there that does the same thing.

-Scott
