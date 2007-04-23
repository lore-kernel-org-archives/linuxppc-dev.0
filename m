Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net
	[151.189.21.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B5203DDF13
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 07:13:05 +1000 (EST)
In-Reply-To: <20070423235502.734e6e67@localhost.localdomain>
References: <20070422232658.5f427fd3@localhost.localdomain>
	<200704222349.42368.arnd@arndb.de>
	<20070423101427.3a1d4983@localhost.localdomain>
	<20070423075957.GA22811@infradead.org>
	<20070423235502.734e6e67@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <44c9a2b88950e3848d2c4e457641eb9b@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH][RFC] PCMCIA support for 8xx using platform devices
Date: Mon, 23 Apr 2007 23:12:58 +0200
To: Vitaly Bordug <vitb@kernel.crashing.org>
Cc: Christoph Hellwig <hch@infradead.org>, linuxppc-dev@ozlabs.org,
	linux-pcmcia@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> That's a horrible argument.  Please do it properly, and let arch/ppc
>> die as it should.  We shouldn't be adding anything to it anymore
>> anyway.
>>
> I understand your point, but we shouldn't trash existing bits either.

Why not?  The things that haven't been ported over yet
obviously are unmaintained.  If we can make the few
remaining board ports in there utterly broken, we
can finally remove arch/ppc/ completely :-)

Since nothing new gets added to arch/ppc/ anymore,
anyone who wants it can get it from an older kernel
tree, no?

[Yes, I'm half joking.  No, not fully.]


Segher
