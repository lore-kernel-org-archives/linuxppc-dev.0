Return-Path: <wim@iguana.be>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 20C8DB7093
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Aug 2009 21:15:04 +1000 (EST)
Received: from mailrelay004.isp.belgacom.be (mailrelay004.isp.belgacom.be
	[195.238.6.170]) by ozlabs.org (Postfix) with ESMTP id 6A02CDDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 21:15:01 +1000 (EST)
Date: Thu, 27 Aug 2009 13:14:58 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Chris Friesen <cfriesen@nortel.com>
Subject: Re: [PATCH] fix book E watchdog to take WDIOC_SETTIMEOUT arg in
	seconds
Message-ID: <20090827111458.GB29382@infomag.iguana.be>
References: <4A8303C6.7070705@nortel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4A8303C6.7070705@nortel.com>
Cc: linuxppc-dev@ozlabs.org, Linux kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Chris,

> The WDIOC_SETTIMEOUT argument is supposed to be a "seconds" value.
> However, the book E wdt currently treats it as a "period" which is
> interpreted in a board-specific way.
> 
> This patch allows the user to pass in a "seconds" value and the driver
> will set the smallest timeout that is at least as large as specified
> by the user.  It's been tested on e500 hardware and works as
> expected.
> 
> The patch only modifies the CONFIG_FSL_BOOKE case, the CONFIG_4xx case
> is left unmodified as I don't have any hardware to test it on.
> 
> Signed-off-by: Chris Friesen <cfriesen@nortel.com>

Added with some small changes to keep checkpatch happy. (removed trailing spaces + changed sizeof(struct watchdog_info) to sizeof(ident) and changed some spaces in tabs).

Now we only need someone that can look at the CONFIG_4xx cases still :-)

Kind regards,
Wim.
