Return-Path: <vojtech@suse.cz>
Received: from mail.suse.cz (styx.suse.cz [82.119.242.94])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4B34C689D8
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jan 2006 09:08:38 +1100 (EST)
Date: Wed, 11 Jan 2006 22:45:32 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20060111214532.GA11962@midnight.suse.cz>
References: <20051225212041.GA6094@hansmi.ch>
	<200512252304.32830.dtor_core@ameritech.net>
	<1135575997.14160.4.camel@localhost.localdomain>
	<d120d5000601111307x451db79aqf88725e7ecec79d2@mail.gmail.com>
	<1137015006.5138.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1137015006.5138.18.camel@localhost.localdomain>
Cc: dtor_core@ameritech.net, linux-kernel@killerfox.forkbomb.ch,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple
	PowerBooks
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 12, 2006 at 08:30:06AM +1100, Benjamin Herrenschmidt wrote:

> > Ok, I am looking at the patch again, and I have a question - do we
> > really need these 3 module parameters? If the goal is to be compatible
> > with older keyboards then shouldn't we stick to one behavior?
> 
> I personally think one parameter is plenty enough (on/off) . Michael,
> can you send Dimitri the latest version of that patch please ?
 
I agree. If you need the compatible behavior.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
