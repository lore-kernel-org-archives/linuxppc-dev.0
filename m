Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id BCB0ADE5A8
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 07:00:44 +1000 (EST)
Date: Wed, 25 Jun 2008 16:22:50 -0500
From: Olof Johansson <olof@lixom.net>
To: Sebastian Siewior <sebastian@breakpoint.cc>
Subject: Re: [PATCH v2] USB: isp1760: Support board-specific hardware
	configurations
Message-ID: <20080625212250.GA13594@lixom.net>
References: <1213719098-28002-1-git-send-email-ncase@xes-inc.com>
	<20080625182425.GA29841@Chamillionaire.breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080625182425.GA29841@Chamillionaire.breakpoint.cc>
Cc: linuxppc-dev@ozlabs.org, Nate Case <ncase@xes-inc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(Taking off the USB cc list)

On Wed, Jun 25, 2008 at 08:24:25PM +0200, Sebastian Siewior wrote:

> Kumar / Josh: Should we describe those DT entries in
> Documentation/powerpc/booting-without-of.txt? In the yes case: which
> section do you recommend?

I don't see a need to. We don't document the IBM busses there either.

Booting-without-of has snowballed into a hold-all bus binding document
that needs to be split up and given separate sections for platforms,
busses and devices, btw.


-Olof
