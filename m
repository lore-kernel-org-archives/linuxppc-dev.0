Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 51E77B7B77
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Nov 2009 23:38:28 +1100 (EST)
Date: Thu, 5 Nov 2009 15:38:26 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gopalpet-B05799 <B05799@freescale.com>
Subject: Re: [PATCH 1/3] fsl_pq_mdio: Fix compiler/sparse warnings (part 1)
Message-ID: <20091105123826.GA2262@oksana.dev.rtsoft.ru>
References: <20091104225256.GA29537@oksana.dev.rtsoft.ru>
	<9F4C7D19E8361D4C94921B95BE08B81B95069E@zin33exm22.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <9F4C7D19E8361D4C94921B95BE08B81B95069E@zin33exm22.fsl.freescale.net>
Cc: netdev@vger.kernel.org, Fleming Andy-AFLEMING <afleming@freescale.com>,
	David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 05, 2009 at 11:11:56AM +0530, Kumar Gopalpet-B05799 wrote:
[...]
> >HI Anton, thanks for the changes. I have only one concern, has 
> >this code been tried for ucc_geth ? I remember I had some 
> >issues with getting the ucc_geth mdio also working. I will 
> >take in these changes and try at my end for ucc_geth.
> 
> Sorry, if my earlier statement was confusing. What I meant was with
> similar changes as Anton's changes
> I had some issues with ucc_geth mdio ( may be Anton's changes don't have
> that issue).

Nope, I see no issues on MPC8360E-MDS using ucc_geth and fsl_pq_mdio
drivers.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
