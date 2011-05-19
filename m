Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2DF6BB6F80
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 16:57:09 +1000 (EST)
Subject: Re: [PATCH 19/37] powerpc: consolidate ipi message mux and demux
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <b9e2ff2d16e4647af0047ddbf6146b6c7433ce6c.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
	<b9e2ff2d16e4647af0047ddbf6146b6c7433ce6c.1305092637.git.miltonm@bga.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 19 May 2011 16:57:02 +1000
Message-ID: <1305788222.7481.46.camel@pasglop>
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

On Wed, 2011-05-11 at 00:29 -0500, Milton Miller wrote:
> Consolidate the mux and demux of ipi messages into smp.c and call
> a new smp_ops callback to actually trigger the ipi.

 .../...

I'm merging the whole series.  I had to do some fixups to this one and
the one adding the CONFIG option, missing cell & wsp bits among others,
but mostly trivial.

Cheers,
Ben.
