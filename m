Return-Path: <linville@bilbo.tuxdriver.com>
Received: from ra.tuxdriver.com (ra.tuxdriver.com [24.172.12.4])
	by ozlabs.org (Postfix) with ESMTP id 292C52BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Jan 2005 08:26:05 +1100 (EST)
Date: Tue, 11 Jan 2005 16:07:52 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Jostein Pettersen <jostein.pettersen@westerngeco.com>
Message-ID: <20050111210750.GE10725@tuxdriver.com>
References: <5.1.0.14.2.20050111210842.024ca490@wgmail3.oslo.eur.slb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5.1.0.14.2.20050111210842.024ca490@wgmail3.oslo.eur.slb.com>
Cc: u-boot-users@lists.sourceforge.net,
	Tormod Tjaberg <ttjaberg@oslo.westerngeco.slb.com>,
	linuxppc-embedded@ozlabs.org
Subject: Re: Linux hangs after early_init()
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Jan 11, 2005 at 09:29:38PM +0100, Jostein Pettersen wrote:

> I'm trying to get Linux (2.4.19) up and running on a BMW board (from 
> Broadcom) with a 8245 processor. I'm using ppcboot 1.2.0.

IMHO, the BMW support from Broadcom is wretchedly bad.  At my former
employer, I implemented my own BMW support and ignored the Broadcom
code completely.  This helped my disposition immensely.

PPCboot 1.2.0 (or any version called "PPCboot") is pretty old.
Did you get reasonably fresh code from Broadcom (if they have any)?
Or is this the same BMW support that has been in the base for years?
Broadcom released a number of variations on the BMW platform,
including multiple CPCI cards and multiple pizza-box variations.
It is extremely likely that your board doesn't match what is in
the ppcboot/u-boot source in some crucial detail, e.g. clock speed.
Some experimentation may be worthwhile.

I spent a couple of years as "the" Linux (and U-Boot) guy for a
company which used nearly every Broadcom board based on BMW (and
Mousse, fwiw).  I may be able to help you.  Contact me off list if
you'd like to arrange something.

Thanks,

John

P.S.  linuxppc-embedded is not the right list to ask about
PPCboot/U-boot...try u-boot-users@lists.sourceforge.net instead...
-- 
John W. Linville
linville@tuxdriver.com
