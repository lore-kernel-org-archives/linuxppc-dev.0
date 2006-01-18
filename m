Return-Path: <linux-kernel@hansmi.ch>
Received: from hansmi.home.forkbomb.ch (hansmi.home.forkbomb.ch
	[213.144.146.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "hansmi.home.forkbomb.ch",
	Issuer "hansmi.home.forkbomb.ch" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1F846688E6
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jan 2006 06:10:17 +1100 (EST)
Date: Wed, 18 Jan 2006 20:10:12 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Frank Arnold <frank@scirocco-5v-turbo.de>
Subject: Re: Feedback: Support for fn key on Apple PowerBooks
Message-ID: <20060118191012.GA7919@hansmi.ch>
References: <1137580063.3466.134.camel@localhost>
	<20060118112049.GA32634@hansmi.ch>
	<1137594633.3466.151.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1137594633.3466.151.camel@localhost>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 18, 2006 at 03:30:33PM +0100, Frank Arnold wrote:
> Anyway, perhaps I'm biased. I can live with both, now that I know where
> to set it.

You can also pass the usbhid.pb_fnmode parameter when loading the
kernel. For example, append="video=radeonfb usbhid.pb_fnmode=2" with
yaboot.

Greets,
Michael

-- 
Gentoo Linux developer, http://hansmi.ch/, http://forkbomb.ch/
