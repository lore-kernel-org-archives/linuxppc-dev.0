Return-Path: <subrata@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 632BBB7085
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jul 2009 18:58:59 +1000 (EST)
Subject: Re: [PATCH Resend2] Remove 'SBC8240 Wind River' Device Driver Code
From: Subrata Modak <subrata@linux.vnet.ibm.com>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1247216007.29541.2.camel@macbook.infradead.org>
References: <20090701135247.27488.10776.sendpatchset@subratamodak.linux.ibm.com>
	<1246846628.5743.2.camel@subratamodak.linux.ibm.com>
	<1247205588.20721.353.camel@localhost.localdomain>
	<1247206539.6630.0.camel@subratamodak.linux.ibm.com>
	<4A56DD51.5040703@gmail.com>
	<1247209961.6630.3.camel@subratamodak.linux.ibm.com>
	<1247210095.20721.362.camel@localhost.localdomain>
	<1247215625.6630.6.camel@subratamodak.linux.ibm.com>
	<1247216007.29541.2.camel@macbook.infradead.org>
Content-Type: text/plain
Date: Fri, 10 Jul 2009 14:28:44 +0530
Message-Id: <1247216324.6630.10.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Cc: carolyn.j.smith@exgate.tek.com, Stephen Rothwell <sfr@canb.auug.org.au>,
	Artem Bityutskiy <dedekind1@gmail.com>, dedekind@infradead.org,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jim Cromie <jim.cromie@gmail.com>,
	Sachin P Sant <sachinp@linux.vnet.ibm.com>,
	linux-next <linux-next@vger.kernel.org>, linux-mtd@lists.infradead.org,
	Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	Scott Wood <scottwood@freescale.com>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
Reply-To: subrata@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-07-10 at 09:53 +0100, David Woodhouse wrote:
> On Fri, 2009-07-10 at 14:17 +0530, Subrata Modak wrote:
> > Is it possible to get this patch through and before 2.6.31 stable is
> > released ?
> 

Hi David,

> Hm, I was ignoring this until I was sure all the last-minute fixes for
> 2.6.31 were out of the way; I was planning to submit it for 2.6.32.
> 
> Do we really need to submit it for 2.6.31? It's not a regression, is it?
> It's been like this for _ages_.

True. But it gives annoying build fails on randconfig next trees. And
we(Sachin & myself) has been reporting it from March/April. If you feel
there is still room to be pushed to 2.6.31, then please do it. Else,
2.6.32 will be fine. Thanks for your support.

Regards--
Subrata

> 
