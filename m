Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao05.cox.net (fed1rmmtao05.cox.net [68.230.241.34])
	by ozlabs.org (Postfix) with ESMTP id 6380B2BEA0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Nov 2004 03:09:48 +1100 (EST)
Date: Thu, 18 Nov 2004 09:09:46 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Guillaume Autran <gautran@mrv.com>
Message-ID: <20041118160946.GD12054@smtp.west.cox.net>
References: <419CBB67.1070301@mrv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <419CBB67.1070301@mrv.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: kernel 2.6.10-rc2 - Embedded MPC8xx - processor option gone !?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Nov 18, 2004 at 10:10:31AM -0500, Guillaume Autran wrote:

> Does anyone know why the option "8xx" in the "Processor Type" screen of 
> the menuconfig is gone ?

It's not gone, it just depends on CONFIG_BROKEN.  A lot of code was
finally synced up, but since it's not fully functional (it's the same
state as was in linuxppc-2.5), it requires CONFIG_BROKEN to be set.

-- 
Tom Rini
http://gate.crashing.org/~trini/
