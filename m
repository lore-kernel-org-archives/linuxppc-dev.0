Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D5BAFB7101
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Sep 2010 08:14:03 +1000 (EST)
Subject: Re: CONFIG_PROVE_LOCKING broken on 83xx (and all of powerpc?)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20100909171116.1b9b6e44@schlenkerla.am.freescale.net>
References: <20100908232124.GB30291@ovro.caltech.edu>
	<1283994156.6515.6.camel@pasglop>
	<20100909025214.GA21846@ovro.caltech.edu>
	<1284001096.6515.33.camel@pasglop>
	<20100909162306.GA3496@ovro.caltech.edu>
	<1284069534.6515.36.camel@pasglop>
	<20100909171116.1b9b6e44@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 10 Sep 2010 08:13:53 +1000
Message-ID: <1284070433.6515.39.camel@pasglop>
Mime-Version: 1.0
Cc: peterz@infradead.org, mingo@redhat.com, linuxppc-dev@lists.ozlabs.org,
	"Ira W. Snyder" <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-09-09 at 17:11 -0500, Scott Wood wrote:
> > I would have expected uboot to warn (the kernel ELF header contains
> the
> > BSS size) but apparently that isn't the case.
> 
> U-Boot doesn't use ELF files with Linux, so it has no idea where the
> BSS is.  uImage is just a wrapper around a flat binary.

Oh, right, I forgot about that... -1 for uboot there. Seriously, it's
time it grows the ability to load ELF or to at least stick an ELF in a
uImage... I've never understood the reasoning for that uImage wrapper
thingy. Definitely causes more problems than it solves in my experience.

Ben.
