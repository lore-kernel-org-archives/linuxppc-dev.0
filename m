Return-Path: <mgreer@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 9449F67AC5
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 May 2006 04:25:34 +1000 (EST)
Date: Tue, 30 May 2006 11:27:46 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Roger Larsson <roger.larsson@norran.net>
Subject: Re: Setting I&D cache enable in the same mtspr instruction
Message-ID: <20060530182746.GA26830@mag.az.mvista.com>
References: <B9FFC3F97441D04093A504CEA31B7C41A62B2F@msilexch01.marvell.com>
	<200605291415.14908.roger.larsson@norran.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200605291415.14908.roger.larsson@norran.net>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, May 29, 2006 at 02:15:14PM +0200, Roger Larsson wrote:
> Is the patch reversed?

Sure looks like it.

> diff -Naur old new > patch
> 
> And what about comments, are they all still valid?
> "enable and invalidate caches" is now only Data cache...
> 
> In cases when I am writing code like this I try to
> include the reason why it is not "optimized" together
> in one write... (or soon someone will do that optimization).

Good point.

> /RogerL

Also, please send the patches *inline*.

Mark
