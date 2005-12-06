Return-Path: <linux-kernel@hansmi.ch>
Received: from hansmi.home.forkbomb.ch (hansmi.home.forkbomb.ch
	[213.144.146.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "hansmi.home.forkbomb.ch",
	Issuer "hansmi.home.forkbomb.ch" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 90DB968883
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Dec 2005 08:12:48 +1100 (EST)
Date: Tue, 6 Dec 2005 22:12:42 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Andy Botting <andy@andybotting.com>
Message-ID: <20051206211242.GA17017@hansmi.ch>
References: <111520052143.16540.437A5680000BE8A60000409C220076369200009A9B9CD3040A029D0A05@comcast.net>
	<70210ED5-37CA-40BC-8293-FF1DAA3E8BD5@comcast.net>
	<20051129000615.GA20843@hansmi.ch>
	<20051130223917.GA15102@hansmi.ch>
	<20051130234653.GB15102@hansmi.ch>
	<1133533712.23129.25.camel@localhost.localdomain>
	<20051204224221.GA28218@hansmi.ch>
	<1133840316.10415.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1133840316.10415.4.camel@localhost>
Cc: Stelian Pop <stelian@popies.net>, Parag Warudkar <kernel-stuff@comcast.net>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org,
	johannes@sipsolutions.net
Subject: Re: PowerBook5,8 - TrackPad update
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Andy

On Tue, Dec 06, 2005 at 02:38:36PM +1100, Andy Botting wrote:
> I managed to get this working on my 15" PowerBook, but the USB id for my

Thanks for testing.

> Keyboard/Trackpad is 0x0214 as opposed to the 0x0215 you have in the
> patch. Are you going to add 0x0214 (and any others?) to this patch
> before sending it off?

Yes, I can add that one. I don't know about any other IDs that will work
with this patch, so I can't add them.

> Also, I found that the patch didn't apply cleanly on my kernel
> 2.6.15-rc5 kernel. I think many of the line numbers were out, so I ended
> up patching the file manually. 

A friend of mine tested it today with a fresh unpacked 2.6.15-rc15 and
it applied cleanly.

Greets,
Michael
