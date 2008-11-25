Return-Path: <bgat@billgatliff.com>
Received: from venus.billgatliff.com (venus.billgatliff.com [209.251.101.201])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1A22CDDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2008 07:18:47 +1100 (EST)
Message-ID: <492C5DC2.9040402@billgatliff.com>
Date: Tue, 25 Nov 2008 14:19:14 -0600
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: [PATCH/RFC] Add Alternative Log Buffer Support for printk Messages
References: <20081125135519.038abf23@zod.rchland.ibm.com>	
	<C5518C2F.13137%gerickson@nuovations.com>	
	<b5e2fc790811251131g63ea9444x57ec0829ca0b069e@mail.gmail.com>	
	<492C573E.9030309@billgatliff.com>
	<b5e2fc790811251207g38d429f3q4eb698b92162d6@mail.gmail.com>
In-Reply-To: <b5e2fc790811251207g38d429f3q4eb698b92162d6@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: linux-embedded@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Stefan Roese <sr@denx.de>, Wolfgang Denx <wd@denx.de>,
	Grant Erickson <gerickson@nuovations.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Matt Sealey wrote:
> Yes, there's FirmWorks, CodeGen SmartFirmware, IBM SLOF and OpenBIOS..
> they're all linked from the OpenBIOS website (along with a bunch of the
> documentation from http://www.openfirmware.org in more-readable formats
> like PDF)
> 
> http://www.openbios.org/
> 
> 
> But here's the real question; why do you need an opensource
> implementation? Curiosity?

That, and I prefer Free *ware whenever that's an option.  :)

Nothing against the commercial alternatives, of course.  But I'm
already doing my own heavy lifting, because my platforms are all
full-custom with very limited production runs.  Since I'm into the
guts of all my code anyway, I'm not inclined to outsource a bootloader
development effort.

Just trying to figure out where the walls of this "sandbox" are.  I've
been aware of the concept of Open Firmware for a while, but haven't
really looked into it before now--- mostly because my impression until
now was that the available implementations were both closed-source,
and not supporting embedded, non-PPC targets like ARM.


b.g.
-- 
Bill Gatliff
bgat@billgatliff.com
