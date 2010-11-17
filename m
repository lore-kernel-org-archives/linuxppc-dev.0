Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1BC60B71A8
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Nov 2010 07:52:27 +1100 (EST)
Subject: Re: [PATCH] powerpc: Per process DSCR
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <9BF17613-A893-4FE8-97BB-3BDCDF740591@kernel.crashing.org>
References: <20101117113130.3702897c@kryten>
	<9BF17613-A893-4FE8-97BB-3BDCDF740591@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 18 Nov 2010 07:52:19 +1100
Message-ID: <1290027139.2147.2062.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-11-17 at 11:15 -0600, Kumar Gala wrote:
> We don't have no stinking DSCR ;).  Would like this to be #ifdef
> CONFIG_PPC_BOOK3S_64.

That or select it from the platform / CPUs that support it.

Cheers,
Ben.
