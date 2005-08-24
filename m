Return-Path: <glikely@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.206])
	by ozlabs.org (Postfix) with ESMTP id E486568036
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Aug 2005 08:20:49 +1000 (EST)
Received: by rproxy.gmail.com with SMTP id a36so256405rnf
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Aug 2005 15:20:48 -0700 (PDT)
Date: Wed, 24 Aug 2005 16:17:09 -0600
To: Tom Rini <trini@kernel.crashing.org>, linuxppc-embedded@ozlabs.org
Message-ID: <20050824221709.GB5397@siegfried.thelikelysolution.ca>
References: <20050823224702.GA3864@siegfried.thelikelysolution.ca>
	<20050824183520.GC15735@smtp.west.cox.net>
	<20050824213521.GA5397@siegfried.thelikelysolution.ca>
	<20050824214734.GE15735@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050824214734.GE15735@smtp.west.cox.net>
From: Grant Likely <glikely@gmail.com>
Subject: Re: [PATCH] Allow ns16550.c to get base baud from rs_table instead
	of BAUD_BASE
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Aug 24, 2005 at 02:47:34PM -0700, Tom Rini wrote:
> I'll buy that, and slightly modify this for 2.6.14, thanks.
Cool, thanks.

> The general problem here (Holy crap! arch/ppc/boot/common/ns16550.c uses
> everything we'd like to kill from <asm*/serial.h>) is come up before,
> and is being slowly fixed.
:)

Now how do I get ns16550 to use a flattened device tree in a clean way?
:P

g.
