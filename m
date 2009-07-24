Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 59F6BB6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jul 2009 18:52:40 +1000 (EST)
Subject: Re: BUG in dma-mapping.h:218 // MESH SCSI driver not working
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stef Simoens <stef.simoens@scarlet.be>
In-Reply-To: <4A68E1CE.4040307@scarlet.be>
References: <4A68E1CE.4040307@scarlet.be>
Content-Type: text/plain
Date: Fri, 24 Jul 2009 18:52:33 +1000
Message-Id: <1248425553.25467.20.camel@pasglop>
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

On Fri, 2009-07-24 at 00:18 +0200, Stef Simoens wrote:
> I tried the latest 2.6.31-rc3-git3 (without any other patch).
> However, I have the same behaviour as the patched 2.6.30 (so: no BUG, 
> but the mesh_abort messages).
> 
> Anybody knows what's going wrong, and how to fix it? I've read the 
> history of this list of June and July ... but I didn't find any other 
> reports of the problem I'm encountering...
> 
Would it be possible for you to roughly find out at what kernel version
it stopped working ? (Some kernels may need my patch to avoid crashing)

I have a machine with a MESH here that -appears- to work, at least it
did last time I tried it which was a couple of weeks ago, I'll try again
just to be sure.

Cheers,
Ben.
