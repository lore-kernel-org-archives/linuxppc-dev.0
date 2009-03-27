Return-Path: <Joakim.Tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9D837DDD1C
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2009 20:37:51 +1100 (EST)
In-Reply-To: <20090327.004237.113711845.davem@davemloft.net>
References: <OF5FC70952.28684E98-ONC1257585.005ADBF9-C1257585.005BDD35@transmode.se>	<20090326180543.GA2406@oksana.dev.rtsoft.ru>
	<OFEB54C9DC.647D70E1-ONC1257585.0064475A-C1257585.0064C85F@transmode.se>
	<20090327.004237.113711845.davem@davemloft.net>
To: David Miller <davem@davemloft.net>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] ucc_geth: Rework the TX logic.
Message-ID: <OF91B13D83.473A03D6-ONC1257586.003493EB-C1257586.0034E4BC@transmode.se>
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Fri, 27 Mar 2009 10:37:45 +0100
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org, leoli@freescale.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Miller <davem@davemloft.net> wrote on 27/03/2009 08:42:37:
> 
> 
> These patches don't apply to the current tree, could you please
> respin your final version against at the very least Linus's tree?

That is strange, had a look at linus tree and I don't see any
changes in his tree that touches the same area/functions.

If I get the time I will look at it a bit more but for now I am
stuck on 2.6.29

 Jocke
