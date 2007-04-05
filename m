Return-Path: <SRS0+dbfa744e487eb5695f7d+1320+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 71701DDEB9
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Apr 2007 00:48:00 +1000 (EST)
Subject: Re: [PATCH v3] Stop pmac_zilog from abusing 8250's device numbers;
	optionally.
From: David Woodhouse <dwmw2@infradead.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, Torben Mathiasen <torben@kernel.org>
In-Reply-To: <20070405.233101.106261123.anemo@mba.ocn.ne.jp>
References: <1175666635.2932.17.camel@shinybook.infradead.org>
	<17939.17962.248566.886449@cargo.ozlabs.ibm.com>
	<1175696383.2774.24.camel@shinybook.infradead.org>
	<20070405.233101.106261123.anemo@mba.ocn.ne.jp>
Content-Type: text/plain
Date: Thu, 05 Apr 2007 10:47:15 -0400
Message-Id: <1175784435.2719.18.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	device@lanana.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-04-05 at 23:31 +0900, Atsushi Nemoto wrote
> Is major 204 minor 192 already allocated?

Of course. The reason it took so long to provide this patch after the
'pmac_zilog doesn't load' bug got reported was because I was waiting for
the new allocation.

> Few weeks ago, I sent a patch to allocate 192...199 for other serial
> driver 

Were those numbers assigned to you or did you just make them up?

-- 
dwmw2
