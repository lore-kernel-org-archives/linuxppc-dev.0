Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8CA0EB716E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Sep 2010 14:18:56 +1000 (EST)
Subject: RE: Memory allocation modifications in ibm_newemac driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
In-Reply-To: <5ABE8A5E96C0364CAF2B4DC1DEB7CEAC127A305B@Mercury.usurf.usu.edu>
References: <5ABE8A5E96C0364CAF2B4DC1DEB7CEAC127A2F09@Mercury.usurf.usu.edu>
	, <5ABE8A5E96C0364CAF2B4DC1DEB7CEAC127A2FBE@Mercury.usurf.usu.edu>
	, <5ABE8A5E96C0364CAF2B4DC1DEB7CEAC127A301B@Mercury.usurf.usu.edu>
	<5ABE8A5E96C0364CAF2B4DC1DEB7CEAC127A305B@Mercury.usurf.usu.edu>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 02 Sep 2010 14:18:50 +1000
Message-ID: <1283401130.16240.9.camel@pasglop>
Mime-Version: 1.0
Cc: "linux-net@vger.kernel.org" <linux-net@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-09-01 at 22:46 +0000, Jonathan Haws wrote:
> 
> Can anyone explain to me why I would be getting this error in the
> first place?  Why is it failing to allocate a page when there are
> pages available?  That does not make any sense to me.

order:1

It's failing to allocate -two- pages.

Cheers,
Ben.
