Return-Path: <mgreer@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id B014F67B9F
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Oct 2006 11:50:02 +1000 (EST)
Date: Sun, 1 Oct 2006 18:51:03 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: [PATCH 2/2] enable generic rtc hook for the MPC8349 mITX
Message-ID: <20061002015103.GB8866@mag.az.mvista.com>
References: <20060926174651.032a474e.kim.phillips@freescale.com>
	<B35FD5A1-2C71-41E2-A014-A2C8D37F10C2@kernel.crashing.org>
	<20060927155853.GB2385@smtp.west.cox.net>
	<20060927234304.0cf4d22d.kim.phillips@freescale.com>
	<20060929232541.GN2385@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060929232541.GN2385@smtp.west.cox.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 29, 2006 at 04:25:41PM -0700, Tom Rini wrote:
> Does this mean we can then rip out some existing code, so long as
> there's associated cleanup / rtc class support additions?

Long term, the todc stuff should disappear.

Mark
