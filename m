Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BC871B70B3
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Dec 2009 07:51:35 +1100 (EST)
Subject: Re: [RFC] doc/powerpc: try to explain why the interrupt numbers are
	off by 16
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20091206113247.GB9937@Chamillionaire.breakpoint.cc>
Date: Wed, 9 Dec 2009 14:51:10 -0600
Message-Id: <B3B43F76-0971-4DFA-95E7-1A1D446A1535@kernel.crashing.org>
References: <d970ff420909040604h1bb3874eg5c79f79f85e713a3@mail.gmail.com>
	<d970ff420909041228h3638e840r34c0c0e79f178e55@mail.gmail.com>
	<d970ff420909041229hb3aa96dya329e06ea56dd1ac@mail.gmail.com>
	<20090906110641.GA11350@Chamillionaire.breakpoint.cc>
	<20090909182857.GB8215@b07421-ec1.am.freescale.net>
	<20090910131544.GB23433@Chamillionaire.breakpoint.cc>
	<20090910222400.GB26587@Chamillionaire.breakpoint.cc>
	<4AA97D50.40209@freescale.com>
	<20091206113247.GB9937@Chamillionaire.breakpoint.cc>
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Alemao <xcarandiru@gmail.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 6, 2009, at 5:32 AM, Sebastian Andrzej Siewior wrote:

> Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
> ---
> Documentation/powerpc/dts-bindings/fsl/mpic.txt |   42 =
+++++++++++++++++++++++
> 1 files changed, 42 insertions(+), 0 deletions(-)
> create mode 100644 Documentation/powerpc/dts-bindings/fsl/mpic.txt

applied to next

- k=
