Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 62DF0DDFB0
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 05:40:51 +1100 (EST)
In-Reply-To: <20070129161502.GA32313@lst.de>
References: <Pine.LNX.4.62.0701251825390.14799@pademelon.sonytel.be>
	<Pine.LNX.4.62.0701251846460.24610@pademelon.sonytel.be>
	<20070126031236.GG18537@lst.de>
	<Pine.LNX.4.62.0701291442530.19906@pademelon.sonytel.be>
	<20070129161502.GA32313@lst.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E674F9E5-3FFC-4291-A03B-0C3BF0F833A6@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/9] ps3: AV Settings Driver
Date: Tue, 30 Jan 2007 19:39:40 +0100
To: Christoph Hellwig <hch@lst.de>
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

>> We can make FB_PS3 (and SND_PS3 later) select PS3_PS3AV. Is that  
>> better?
>> I prefer not to make it unconditional, as people who want to run  
>> their PS3s
>> headless don't need it.
>
> Ok.  Even better would be handling it on the makefile level, by doing
>
> obj-$(CONFIG_FB_PS3)	+= ps3_av.o
> obj-$(CONFIG_SND_PS3)	+= ps3_av.o

I don't think Kbuild will be too happy with that.  Or does
it filter out duplicate files everywhere (dep, build, link)?


Segher
