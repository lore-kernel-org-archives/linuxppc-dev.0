Return-Path: <SRS0+dbfa744e487eb5695f7d+1320+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CC365DDE4A
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Apr 2007 01:18:54 +1000 (EST)
Subject: Re: [PATCH v3] Stop pmac_zilog from abusing 8250's device numbers;
	optionally.
From: David Woodhouse <dwmw2@infradead.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070406.000913.28784231.anemo@mba.ocn.ne.jp>
References: <1175696383.2774.24.camel@shinybook.infradead.org>
	<20070405.233101.106261123.anemo@mba.ocn.ne.jp>
	<1175784435.2719.18.camel@shinybook.infradead.org>
	<20070406.000913.28784231.anemo@mba.ocn.ne.jp>
Content-Type: text/plain
Date: Thu, 05 Apr 2007 11:18:12 -0400
Message-Id: <1175786292.2719.23.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	torben@kernel.org, device@lanana.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-04-06 at 00:09 +0900, Atsushi Nemoto wrote:
> 
> What I did is just send a patch includeing devices.txt changes to
> lkml, device@lanana.org, and some others.
> 
> Maybe I should have sent "request" (not patch) mail to
> device@lanana.org first?

Well, that's what it says right underneath the line in devices.txt which
says:
	**** DEVICE DRIVERS AUTHORS PLEASE READ THIS ****

It goes on to say...

"Third, please don't assume that the distributed version of the list is
up to date.  Due to the number of registrations I have to maintain it
in "batch mode", so there is likely additional registrations that
haven't been listed yet."

-- 
dwmw2
