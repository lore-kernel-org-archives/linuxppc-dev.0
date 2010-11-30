Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8EDE4B70EF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Nov 2010 16:31:39 +1100 (EST)
Subject: Re: [PATCH 0/4] More ppc64 nvram code cleanup
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jim Keniston <jkenisto@us.ibm.com>
In-Reply-To: <20101112045346.4290.43739.stgit@localhost.localdomain>
References: <20101112045346.4290.43739.stgit@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 30 Nov 2010 16:25:58 +1100
Message-ID: <1291094758.32570.355.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-11-11 at 20:53 -0800, Jim Keniston wrote:
> This series contains some fixups to Ben Herrenschmidt's Aug. 2 patch
> set, "[RFC] Clean up ppc64 nvram code" --
> http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-August/084601.html
> 
> These patches apply atop Ben's 11-patch series.
> ---
> 
> Jim Keniston (4):
>       Handle partition names >= 12 chars
>       Fix NVRAM partition list setup
>       Fix nvram_create_partition() arg order
>       Fix powerpc nvram init order

I've folded the first two (or a slightly different variant) in my series
and applied the two next on top. I'll post that new version of the
series to the list after a few tests today and will include it in next
in a couple of days, possibly along with your other patches provided
they survive my review :-)

Cheers,
Ben.
