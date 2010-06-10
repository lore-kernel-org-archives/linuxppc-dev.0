Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8F3481007D9
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jun 2010 16:31:12 +1000 (EST)
Subject: Re: [PATCH] [powerpc] do not expect executable permissions for
	in-tree shell scripts
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sean MacLennan <smaclennan@pikatech.com>
In-Reply-To: <20100605140010.653d9f6e@opus.seanm.ca>
References: <20100605081039.GA21300@aepfle.de>
	<20100605133210.11f504c3@opus.seanm.ca>
	<20100605174437.GA16229@aepfle.de>
	<20100605140010.653d9f6e@opus.seanm.ca>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 10 Jun 2010 16:26:29 +1000
Message-ID: <1276151189.1962.47.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2010-06-05 at 14:00 -0400, Sean MacLennan wrote:
> On Sat, 5 Jun 2010 19:44:37 +0200
> Olaf Hering <olaf@aepfle.de> wrote:
> 
> > Maybe.
> > As it stands right now, mkuboot.sh does not run without bash.
> > 
> > 
> > And:
> > Reality check please.
> > A _development system_ without bash, installed per default on every
> > sane Linux distro, does most likely not exist.
> 
> Hmmm, can't argue with that. I wouldn't consider building a kernel on
> the warp sane ;) And to be honest, I am not sure anyone has tried. We
> officially support it, but I have never done it and don't plan to try.

I still don't like it very much.. why not chmod'ing it +x instead ? :-)

Cheers,
Ben.
