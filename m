Return-Path: <olaf@aepfle.de>
Received: from mo-p00-ob.rzone.de (mo-p00-ob.rzone.de [81.169.146.160])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DA4F5B7D61
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Jun 2010 03:44:46 +1000 (EST)
Date: Sat, 5 Jun 2010 19:44:37 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH] [powerpc] do not expect executable permissions for
	in-tree shell scripts
Message-ID: <20100605174437.GA16229@aepfle.de>
References: <20100605081039.GA21300@aepfle.de>
	<20100605133210.11f504c3@opus.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20100605133210.11f504c3@opus.seanm.ca>
Cc: linuxppc-dev@ozlabs.org, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jun 05, Sean MacLennan wrote:

> On Sat, 5 Jun 2010 10:10:39 +0200
> Olaf Hering <olaf@aepfle.de> wrote:
> 
> > scripts in the kernel source do not have executable permissions if
> > they were created with patch(1) run mkuboot.sh with bash, its tagged
> > as bash script.
> 
> Wouldn't it be better to use ${SHELL}? Not every system has bash.

Maybe.
As it stands right now, mkuboot.sh does not run without bash.


And:
Reality check please.
A _development system_ without bash, installed per default on every sane
Linux distro, does most likely not exist.


Olaf
