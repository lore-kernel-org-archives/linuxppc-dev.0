Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 5C53BB7D68
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Jun 2010 04:00:25 +1000 (EST)
Date: Sat, 5 Jun 2010 14:00:10 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] [powerpc] do not expect executable permissions for
	in-tree shell scripts
Message-ID: <20100605140010.653d9f6e@opus.seanm.ca>
In-Reply-To: <20100605174437.GA16229@aepfle.de>
References: <20100605081039.GA21300@aepfle.de>
	<20100605133210.11f504c3@opus.seanm.ca>
	<20100605174437.GA16229@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 5 Jun 2010 19:44:37 +0200
Olaf Hering <olaf@aepfle.de> wrote:

> Maybe.
> As it stands right now, mkuboot.sh does not run without bash.
> 
> 
> And:
> Reality check please.
> A _development system_ without bash, installed per default on every
> sane Linux distro, does most likely not exist.

Hmmm, can't argue with that. I wouldn't consider building a kernel on
the warp sane ;) And to be honest, I am not sure anyone has tried. We
officially support it, but I have never done it and don't plan to try.

Cheers,
   Sean
