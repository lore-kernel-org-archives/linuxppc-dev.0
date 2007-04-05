Return-Path: <SRS0+dbfa744e487eb5695f7d+1320+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 56431DDE49
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Apr 2007 08:59:56 +1000 (EST)
Subject: Re: [PATCH v3] Stop pmac_zilog from abusing 8250's device numbers;
	optionally.
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17941.32261.914571.136583@cargo.ozlabs.ibm.com>
References: <1175610345.2665.15.camel@shinybook.infradead.org>
	<17938.57292.870224.132415@cargo.ozlabs.ibm.com>
	<1175642916.10567.24.camel@shinybook.infradead.org>
	<20070403212928.GA12951@cynthia.pants.nu>
	<20070404022544.59b022a6@the-village.bc.nu>
	<17939.10130.687893.167511@cargo.ozlabs.ibm.com>
	<1175663999.2932.8.camel@shinybook.infradead.org>
	<17939.15726.114059.679277@cargo.ozlabs.ibm.com>
	<1175666635.2932.17.camel@shinybook.infradead.org>
	<17939.17962.248566.886449@cargo.ozlabs.ibm.com>
	<1175696383.2774.24.camel@shinybook.infradead.org>
	<17940.14667.503535.507564@cargo.ozlabs.ibm.com>
	<1175777154.2719.14.camel@shinybook.infradead.org>
	<17941.32261.914571.136583@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Thu, 05 Apr 2007 18:59:19 -0400
Message-Id: <1175813960.2764.21.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-04-06 at 08:53 +1000, Paul Mackerras wrote:
> Why would the numbers be prone to change, any more than they are
> already?

Because now 8250 ports can actually coexist with Zilog ports. Before my
fix, it was strictly one or the other.

-- 
dwmw2
