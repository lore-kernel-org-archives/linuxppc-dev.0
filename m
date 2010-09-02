Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 145C0B716D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Sep 2010 14:18:18 +1000 (EST)
Subject: RE: Memory allocation modifications in ibm_newemac driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
In-Reply-To: <5ABE8A5E96C0364CAF2B4DC1DEB7CEAC127A301B@Mercury.usurf.usu.edu>
References: <5ABE8A5E96C0364CAF2B4DC1DEB7CEAC127A2F09@Mercury.usurf.usu.edu>
	, <5ABE8A5E96C0364CAF2B4DC1DEB7CEAC127A2FBE@Mercury.usurf.usu.edu>
	<5ABE8A5E96C0364CAF2B4DC1DEB7CEAC127A301B@Mercury.usurf.usu.edu>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 02 Sep 2010 14:18:12 +1000
Message-ID: <1283401092.16240.8.camel@pasglop>
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

On Wed, 2010-09-01 at 22:04 +0000, Jonathan Haws wrote:
> Okay, I think I have all the issues worked out and can now send and
> receive any size packet without a hiccup.  I have tested this in our
> system setup as well with data being sent out to disk and did not see
> any problems there either (since it only ever allocates a single page,
> never more).
> 
> Is this something that may be wanted in the mainline?  I have not run
> full benchmarks, but I anticipate that my modified driver is slightly
> slower than the mainline driver because we keep track of an SKB ring,
> as well as a ring of pages and allocate both on each packet received.

Well, it won't hurt to post the patch to review :-)

Make sure to CC me as I more/less maintain that driver.

Cheers,
Ben.
