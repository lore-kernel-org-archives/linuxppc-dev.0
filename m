Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DD8DADDF38
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 09:21:57 +1000 (EST)
Subject: Re: [PATCH 3/6] Consolidate of_find_property
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20070425.161309.02297897.davem@davemloft.net>
References: <1177539404.14873.199.camel@localhost.localdomain>
	<20070425.152419.110959714.davem@davemloft.net>
	<1177541265.14873.222.camel@localhost.localdomain>
	<20070425.161309.02297897.davem@davemloft.net>
Content-Type: text/plain
Date: Thu, 26 Apr 2007 09:21:39 +1000
Message-Id: <1177543299.14873.229.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: sfr@canb.auug.org.au, paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Meanwhile any feedback on the idea of pushing all of this
> consolidation and cleanup work through one of our trees
> instead of having all of these difficult dependencies
> between the two?

I'll leave that between you, paulus and stephen as I'm working on
something else at the moment :-)

Ben.
