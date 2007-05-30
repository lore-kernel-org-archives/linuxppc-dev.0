Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound6-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 134A6DDF9D
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 03:37:45 +1000 (EST)
Message-ID: <465DB1EB.5010603@am.sony.com>
Date: Wed, 30 May 2007 10:18:35 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch 6/7] ps3: ROM Storage Driver
References: <20070525083607.784351000@sonycom.com>	<20070525083632.677742000@sonycom.com>
	<20070529104948.GC29351@lst.de>	<Pine.LNX.4.62.0705291308280.7698@pademelon.sonytel.be>	<20070530101348.GD24586@lst.de>
	<1180525555.19517.268.camel@localhost.localdomain>
In-Reply-To: <1180525555.19517.268.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, Christoph Hellwig <hch@lst.de>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Wed, 2007-05-30 at 12:13 +0200, Christoph Hellwig wrote:
>> 
>> For any sane hypervisor or hardware the copy should be worth
>> than that.  Then again a sane hardware or hypervisor would support
>> SG requests..
> 
> Agreed... Sony should fix that, it's a bit ridiculous.

Yes, if only to put an end to seeing this kind of comment over 
and over again.

-Geoff
