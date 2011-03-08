Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 17519B6EEA
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Mar 2011 15:48:28 +1100 (EST)
Subject: Re: [PATCH 28/28] powerpc: Enable GENERIC_HARDIRQS_NO_DEPRECATED.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20110308043858.GC23260@angua.secretlab.ca>
References: <cover.1299541392.git.buytenh@wantstofly.org>
	<20110308000023.GG16649@mail.wantstofly.org>
	<20110308043858.GC23260@angua.secretlab.ca>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 08 Mar 2011 15:48:09 +1100
Message-ID: <1299559689.22236.3.camel@pasglop>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
	Lennert Buytenhek <buytenh@wantstofly.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-03-07 at 21:38 -0700, Grant Likely wrote:
> 
> All 28 look good to me, it compiles with all the defconfigs I tried,
> and it boots on mpc5200.  Feel free to add:
> 
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> 
> Ben, I've got this series applied against 2.6.38-rc7 in a branch on my
> private repo.  If you want me to I can push it out to my powerpc/next
> branch so that it gets some linux-next exposure.

Nah, I'll pick it up, will do some tests first. I'm just finishing some
CPU hotplug fixes/cleanups now and will do that next.

Cheers,
Ben.
