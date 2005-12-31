Return-Path: <dhlii@dlasys.net>
Received: from xm.dlasys.net (unknown [24.152.213.223])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A395D68914
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  2 Jan 2006 21:46:26 +1100 (EST)
Message-ID: <43B6B32A.5060606@dlasys.net>
Date: Sat, 31 Dec 2005 11:34:50 -0500
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
References: <11359385991901-git-send-email-grant.likely@secretlab.ca>	<43B5E37A.4020008@dlasys.net>
	<43B601CC.1000102@secretlab.ca>
In-Reply-To: <43B601CC.1000102@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 8/8] Add support for Xilinx ML403 reference design
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> David H. Lynch Jr. wrote:

> 
> Since the E-12 is a commercially available board, it would be useful to
> have the patches on the ML, even if they don't get applied to mainline.

	So at what state should things be at before posting them ?

	Right now:
		The basic E-12 stuff is complete - though it couls use some polish. It
was based on the ML300 code, and almost certainly overlaps and conflicts
with your ML403 work. I would be happy to reconcile them, but I would
need to know what to work against.

		I am not a git expert at this point. I am working against the 2.6.14.5
source3 on kernel.org. There are numerous git trees what is the right one ?

	
		The serial/console drivers for the "Keyhole" - a bidirectional link
between a Linux/Windows development host and the E-12, and the Xilinx
UartLite are in (hopefully) late debugging, Output is probably complete,
UartLite input needs testing, Keyhole input needs alot of work - among
other things the host side is still only a display, so it is somewhat
difficult to do the Linux input side.
