Return-Path: <tony@atomide.com>
Received: from mho-02-ewr.mailhop.org (mho-02-ewr.mailhop.org [204.13.248.72])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BAB10B6EEB
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 15 Jan 2011 06:38:08 +1100 (EST)
Date: Fri, 14 Jan 2011 11:19:57 -0800
From: Tony Lindgren <tony@atomide.com>
To: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] drivers: char: hvc: add arm JTAG DCC console support
Message-ID: <20110114191956.GK4957@atomide.com>
References: <1291145141-18301-1-git-send-email-dwalker@codeaurora.org>
	<4CF5DD63.40803@codeaurora.org>
	<1291229696.14404.39.camel@c-dwalke-linux.qualcomm.com>
	<4CF6AE04.6030201@codeaurora.org> <4CFE86AC.9010801@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4CFE86AC.9010801@codeaurora.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>,
	Daniel Walker <dwalker@codeaurora.org>, Mike Frysinger <vapier@gentoo.org>,
	Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>,
	linux-arm-msm@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel@vger.kernel.org,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Stephen Boyd <sboyd@codeaurora.org> [101207 11:00]:
> On 12/01/2010 12:20 PM, Stephen Boyd wrote:
> > Definitely for TX since it seems like a redundant loop, but I agree RX
> > code has changed. Instead of
> >
> > If RX buffer full
> > Poll for RX buffer full
> > Read character from RX buffer
> >
> > we would have
> >
> > If RX buffer full
> > Read character from RX buffer
> >
> > which doesn't seem all that different assuming the RX buffer doesn't go
> > from full to empty between the If and Poll steps. Hopefully Tony knows more.
> >
> 
> Tony, any thoughts?

Sorry for the delay, looks like I'm only 1 month behind with email..
Sounds like it should work to me. I can try it out if you point me
to a patch.

Regards,

Tony
