Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1043AB7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jul 2009 09:52:36 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 52632DDDE1
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Jul 2009 09:52:35 +1000 (EST)
Subject: Re: [PATCH] powerpc: minor Makefile simplification through use of
	cc-ifversion
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20090723213132.GA9514@merkur.ravnborg.org>
References: <200907232057.19942.elendil@planet.nl>
	<20090723213132.GA9514@merkur.ravnborg.org>
Content-Type: text/plain
Date: Fri, 24 Jul 2009 09:52:26 +1000
Message-Id: <1248393146.25467.13.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Frans Pop <elendil@planet.nl>,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-07-23 at 23:31 +0200, Sam Ravnborg wrote:
> On Thu, Jul 23, 2009 at 08:57:18PM +0200, Frans Pop wrote:
> > Signed-off-by: Frans Pop <elendil@planet.nl>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>

Thanks, will include in my next batch.

Cheers,
Ben.
