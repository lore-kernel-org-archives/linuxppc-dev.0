Return-Path: <linux-kernel@hansmi.ch>
Received: from hansmi.home.forkbomb.ch (hansmi.home.forkbomb.ch
	[213.144.146.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "hansmi.home.forkbomb.ch",
	Issuer "hansmi.home.forkbomb.ch" (not verified))
	by ozlabs.org (Postfix) with ESMTP id AFF2A6893F
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jan 2006 21:57:26 +1100 (EST)
Date: Sat, 14 Jan 2006 11:57:21 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple PowerBooks
Message-ID: <20060114105721.GA18170@hansmi.ch>
References: <20051225212041.GA6094@hansmi.ch>
	<20060113074749.GA7103@midnight.suse.cz>
	<20060113220252.GA1516@hansmi.ch>
	<200601132358.33861.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200601132358.33861.dtor_core@ameritech.net>
Cc: linux-kernel@killerfox.forkbomb.ch, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Vojtech Pavlik <vojtech@suse.cz>,
	linux-input@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Dmitry

On Fri, Jan 13, 2006 at 11:58:33PM -0500, Dmitry Torokhov wrote:
> One little thing - I think that we should report FN key even if PowerBook
> support is disabled. Can I solicit input on the patch below (I also rearranged
> teh code slightly)? 

Yeah, all looks fine for me.

Greets,
Michael
