Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9B01CDDEC2
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 01:47:36 +1100 (EST)
Subject: Re: [PATCH 1/5] powerpc: generic time suspend/resume code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <20070319105357.964696000@sipsolutions.net>
References: <20070319105352.771599000@sipsolutions.net>
	<20070319105357.964696000@sipsolutions.net>
Content-Type: text/plain
Date: Mon, 19 Mar 2007 15:47:31 +0100
Message-Id: <1174315651.5044.4.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-03-19 at 11:53 +0100, Johannes Berg wrote:
> plain text document attachment (001-time-resume.patch)
> This patch removes the time suspend/restore code that was done through
> a PMU notifier in arch/platforms/powermac/time.c.
> 
> Instead, introduce arch/powerpc/sysdev/timer.c which creates a sys
> device and handles time of day suspend/resume through that.
> 
> This should probably be replaced by using the generic RTC framework
> but for now it gets rid of the arcane powermac specific hack.
> 
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
