Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ECF3DDE4B2
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 15:34:57 +1000 (EST)
Message-Id: <890B4092-5F25-44CB-A63D-3E6F3C8CB0BC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20080821151612.4bdf0692.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [2.6 patch] Add cuImage.mpc866ads to the bootwrapper as a
	cuboot-8xx target
Date: Thu, 21 Aug 2008 00:34:27 -0500
References: <20080731161020.GD20212@cs181140183.pp.htv.fi>
	<20080821151612.4bdf0692.sfr@canb.auug.org.au>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Adrian Bunk <bunk@kernel.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 21, 2008, at 12:16 AM, Stephen Rothwell wrote:

> Hi all,
>
> Anyone going to add this patch to some tree (I have had it in linux- 
> next
> for a while).
>
> http://patchwork.ozlabs.org/linuxppc/patch?id=19962

I'll grab it for 2.6.27 as it address a build failure.

- k
