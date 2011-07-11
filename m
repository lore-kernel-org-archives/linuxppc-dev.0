Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE003.bigfish.com (va3ehsobe003.messaging.microsoft.com
	[216.32.180.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 477ADB6F82
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jul 2011 06:06:30 +1000 (EST)
Date: Mon, 11 Jul 2011 15:06:12 -0500
From: Scott Wood <scottwood@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: RFC: top level compatibles for virtual platforms
Message-ID: <20110711150612.50f5d75c@schlenkerla.am.freescale.net>
In-Reply-To: <CACxGe6sRjGzk2iVDXCMZS=AZk8mc_CtGp7CSqnO2WY-yih1Q8A@mail.gmail.com>
References: <9F6FE96B71CF29479FF1CDC8046E150316EAB6@039-SN1MPN1-003.039d.mgd.msft.net>
	<CAOZdJXVp5LHqYEMoqpnKEkuWyuE6kwU+Z9VwUYLPcz-+h_gqfw@mail.gmail.com>
	<9F6FE96B71CF29479FF1CDC8046E150316F97F@039-SN1MPN1-003.039d.mgd.msft.net>
	<CACxGe6sRjGzk2iVDXCMZS=AZk8mc_CtGp7CSqnO2WY-yih1Q8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Tabi Timur-B04825 <B04825@freescale.com>, Alexander Graf <agraf@suse.de>,
	Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 12 Jul 2011 04:59:33 +0900
Grant Likely <grant.likely@secretlab.ca> wrote:

> However, compatible values are cheap and while theoretically any
> hypervisor could create a similar machine, the reality is probably
> subtle difference between the implementations.  I'd rather see the
> compatible reflect the specific implementation.

That's what the hypervisor node is for.  We have a tree, let's use it. :-)

-Scott
