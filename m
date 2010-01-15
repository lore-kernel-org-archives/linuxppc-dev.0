Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2E1BC1007D2
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jan 2010 04:53:32 +1100 (EST)
Subject: Re: Kexec support for FSL-BookE, take two
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1263573697-17839-1-git-send-email-linuxppc-dev@ml.breakpoint.cc>
Date: Fri, 15 Jan 2010 11:53:13 -0600
Message-Id: <80DDCCCD-D62C-4A66-AA8B-E0937266AF55@kernel.crashing.org>
References: <1263573697-17839-1-git-send-email-linuxppc-dev@ml.breakpoint.cc>
To: Sebastian Andrzej Siewior <linuxppc-dev@ml.breakpoint.cc>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 15, 2010, at 10:41 AM, Sebastian Andrzej Siewior wrote:

> This is take two :)
> SMP support did not work in the first one and due to the lack of a =
working
> SMP machine it is still absent. I took the e500v1 problem into account =
and
> the result is that I now use multiple 256MiB mappings.
> The final mapping covers the first 2GiB so the part of the highmem =
should
> be also covered and not just kernel memory.
>=20
> The first three patches prepare the entry code to work outside of the
> first page. Patch 4 simply moves code and finally patch 5 implements =
the
> kexec functionality.

What do you think we need for SMP support? I'm happy to test out on SMP =
HW (8572)

- k=
