Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 99049B6F80
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Jun 2011 12:33:24 +1000 (EST)
Subject: Re: [PATCH] powerpc/85xx: disable timebase synchronization under
	the hypervisor
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tabi Timur-B04825 <B04825@freescale.com>
In-Reply-To: <4DF814A3.7070209@freescale.com>
References: <1308092673-13045-1-git-send-email-timur@freescale.com>
	<20110614181406.294cdf5f@schlenkerla.am.freescale.net>
	<4DF7EB8E.8020308@freescale.com>
	<20110614182517.776d7e77@schlenkerla.am.freescale.net>
	<1308103091.2635.13.camel@pasglop>  <4DF814A3.7070209@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 15 Jun 2011 12:33:16 +1000
Message-ID: <1308105196.2635.16.camel@pasglop>
Mime-Version: 1.0
Cc: McClintock Matthew-B29882 <B29882@freescale.com>,
	Wood Scott-B07421 <B07421@freescale.com>,
	Gala Kumar-B11780 <B11780@freescale.com>,
	"paulus@samba.org" <paulus@samba.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-06-15 at 02:10 +0000, Tabi Timur-B04825 wrote:
> Benjamin Herrenschmidt wrote:
> > We might want to generically have a CPU feature bit indicating we are
> > running in guest vs. HV mode. I know Paulus is planning to introduce one
> > so you may want to sync with him.
> 
> Are you talking about CPU_FTR_HVMODE_206?

Well, not exactly. Paul wants to break that up since we're adding some
primitive support for 201 HV mode too (for 970's). Last we discussed,
the plan was to go for a generic HV mode bit and a separate bit for the
version.

Cheers,
Ben.
