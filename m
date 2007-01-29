Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound8-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7C49EDE031
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 06:24:58 +1100 (EST)
Message-ID: <45BE4A02.3070206@am.sony.com>
Date: Mon, 29 Jan 2007 11:24:50 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/9] ps3: AV Settings Driver
References: <Pine.LNX.4.62.0701251825390.14799@pademelon.sonytel.be>	<Pine.LNX.4.62.0701251846460.24610@pademelon.sonytel.be>	<20070126031236.GG18537@lst.de>	<Pine.LNX.4.62.0701291442530.19906@pademelon.sonytel.be>
	<20070129161502.GA32313@lst.de>
In-Reply-To: <20070129161502.GA32313@lst.de>
Content-Type: text/plain; charset=us-ascii
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>, James Simmons <jsimmons@infradead.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christoph Hellwig wrote:
>> I guess you want us to do the same for the virtual uart, i.e. let PS3_PS3AV and
>> PS3_SYS_MANAGER select PS3_VUART?
> 
> Yes, that probably makes sense aswell.

I'll start work on sys-manager soon, so I'll set this up.
