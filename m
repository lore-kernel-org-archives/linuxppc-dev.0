Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 80CD5DDDEF
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2008 11:10:18 +1100 (EST)
Subject: Re: [PATCH] powerpc: add 16K/64K pages support for the 44x PPC32
	architectures.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hollis Blanchard <hollis@penguinppc.org>
In-Reply-To: <fb412d760812011506x37339fddue100a144e585782e@mail.gmail.com>
References: <1227829488-8260-1-git-send-email-yanok@emcraft.com>
	<fb412d760812011506x37339fddue100a144e585782e@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 02 Dec 2008 11:09:56 +1100
Message-Id: <1228176596.7356.150.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, dzu@denx.de, wd@denx.de,
	Vladimir Panfilov <pvr@emcraft.com>, Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-12-01 at 17:06 -0600, Hollis Blanchard wrote:
> Ben, you had some comments on the previous version of this patch. Have
> those been addressed to your satisfaction? If so, could you please
> queue this for 2.6.29?
> 
>From the description, they have, however I haven't had a chance to look
in details at the code yet. I would like to see these in 2.6.29 too
though, I'll have a look asap.

Cheers,
Ben.
