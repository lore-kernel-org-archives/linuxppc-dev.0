Return-Path: <SRS0+3d12a902f91e03596c36+1336+infradead.org+dwmw2@canuck.srs.infradead.org>
Received: from canuck.infradead.org (canuck.infradead.org [209.217.80.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 00B16DDE9E
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 22 Apr 2007 05:23:16 +1000 (EST)
Subject: Re: Problem cloning Linus' GIT tree!
From: David Woodhouse <dwmw2@infradead.org>
To: Laurent Pinchart <laurent.pinchart@technotrade.biz>
In-Reply-To: <200704171532.00215.laurent.pinchart@technotrade.biz>
References: <18A49CF3586FC14290887ECC63C9141F0104D047@exchange2003.dspace.de>
	<200704171532.00215.laurent.pinchart@technotrade.biz>
Content-Type: text/plain
Date: Sat, 21 Apr 2007 20:23:05 +0100
Message-Id: <1177183385.2854.39.camel@pmac.infradead.org>
Mime-Version: 1.0
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

On Tue, 2007-04-17 at 15:31 +0200, Laurent Pinchart wrote:
> I'm not sure about that. The http repository is not broken, it's just 
> stripped. The http:// protocol handler in git might need to be fixed. 

The http:// protocol handler is rarely going to work properly. If your
firewall is broken, I would suggest just fixing it.

-- 
dwmw2
