Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id A8478B70AE
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jul 2010 23:34:20 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH v3] of: Create asm-generic/of.h and provide default
	of_node_to_nid()
Date: Tue, 27 Jul 2010 15:34:01 +0200
References: <20100726220405.1550.63442.stgit@angua>
	<20100726222627.GA23501@merkur.ravnborg.org>
	<AANLkTikcV3jJUm_My-oK-drudSDz3M2iH1cWhxdt+W1s@mail.gmail.com>
In-Reply-To: <AANLkTikcV3jJUm_My-oK-drudSDz3M2iH1cWhxdt+W1s@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201007271534.01250.arnd@arndb.de>
Cc: sfr@canb.auug.org.au, microblaze-uclinux@itee.uq.edu.au,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	sparclinux@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
	davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 27 July 2010, Grant Likely wrote:
> > I suggest to go back to v2 of your patch where you use asm-generic/of.h.
> 
> Stephen suggested dropping asm-generic/of.h.  I'm happy to do it either way.

I don't mind adding stuff to asm-generic, but I think in this case it would
be easier to keep this in linux/of.h because there is nothing wrong with
all architectures including it.

Most files in asm-generic are there only for historical reasons, where some
architectures use them but others don't. IMHO we should use the include/linux
headers preferred for new stuff though.

	Arnd
