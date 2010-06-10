Return-Path: <olaf@aepfle.de>
Received: from mo-p00-ob.rzone.de (mo-p00-ob.rzone.de [81.169.146.161])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D383B1007D1
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jun 2010 01:20:50 +1000 (EST)
Date: Thu, 10 Jun 2010 17:20:40 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] [powerpc] do not expect executable permissions for
	in-tree shell scripts
Message-ID: <20100610152040.GA30274@aepfle.de>
References: <20100605081039.GA21300@aepfle.de>
	<20100605133210.11f504c3@opus.seanm.ca>
	<20100605174437.GA16229@aepfle.de>
	<20100605140010.653d9f6e@opus.seanm.ca>
	<1276151189.1962.47.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1276151189.1962.47.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, stable@kernel.org,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 10, Benjamin Herrenschmidt wrote:

> I still don't like it very much.. why not chmod'ing it +x instead ? :-)

I looked at a few other scripts in the source tree, they are called with
$(CONFIG_SHELL) <name>, or perl <name>, or awk <name> or even sh <name>.

So my change adds some sort of consistency and makes packaging more robust.


Olaf
