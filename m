Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 15FB1DDED2
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jul 2008 18:51:10 +1000 (EST)
Subject: Re: [PATCH 0/5] powerpc tracehook
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20080727.005518.08712012.davem@davemloft.net>
References: <20080727064859.69692154280@magilla.localdomain>
	<1217145165.11188.132.camel@pasglop>
	<20080727.005518.08712012.davem@davemloft.net>
Content-Type: text/plain
Date: Sun, 27 Jul 2008 18:51:01 +1000
Message-Id: <1217148661.11188.134.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
	roland@redhat.com
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > Thanks for this. I haven't followed the story of tracehook so far, are
> > those patches dependent on something else or it's all already upstream
> > and do you think that's still 2.6.27 material ?
> 
> The infrastructure is in Linus's tree.

Thanks David. I'll review these on monday and if Paul has no objection,
I suppose we can still merge them.

Cheers,
Ben.
