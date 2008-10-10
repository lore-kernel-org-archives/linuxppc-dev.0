Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 9D124DDE20
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 10:47:24 +1100 (EST)
Date: Fri, 10 Oct 2008 19:47:21 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Stefan Roese" <sr@denx.de>
Subject: Re: [PATCH v7] PPC440EPx gpio driver
Message-ID: <20081010194721.0ae8785a@lappy.seanm.ca>
In-Reply-To: <200810101602.33052.sr@denx.de>
References: <48EF5DDB.7060302@harris.com>
	<200810101602.33052.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 10 Oct 2008 16:02:32 +0200
"Stefan Roese" <sr@denx.de> wrote:

> On Friday 10 October 2008, Steven A. Falco wrote:
> > This patch adds support for the GPIO functions of PPC40x and PPC44x
> > SOCs.
> 
> Looks good. But you should change the subject line now. Its not only
> a PPC440EPx gpio driver but ppc4xx. Also please add "powerpc/4xx: "
> to the beginning of the subject line. And you should always send 4xx
> related patches to the subsystem maintainer too (CC), in this case
> Josh Boyer.
> 
> > Signed-off-by: Steve Falco <sfalco at harris.com>
> 
> You can add my:
> 
> Acked-by: Stefan Roese <sr@denx.de>
> 
> in the next patch revision. :)

Tested on the warp (440EP).

Acked-by: Sean MacLennan <smaclennan@pikatech.com>

Cheers,
   Sean
