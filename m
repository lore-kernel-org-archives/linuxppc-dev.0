Return-Path: <bwarren@qstreams.com>
Received: from smtp103.biz.mail.re2.yahoo.com (smtp103.biz.mail.re2.yahoo.com
	[68.142.229.217]) by ozlabs.org (Postfix) with SMTP id 3D955DDE42
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Apr 2007 01:12:18 +1000 (EST)
Subject: Re: Multiple Boards with same MAC addresses - problem.
From: Ben Warren <bwarren@qstreams.com>
To: powerpc440 <powerpc440@googlemail.com>
In-Reply-To: <461BA458.2010605@googlemail.com>
References: <461BA458.2010605@googlemail.com>
Content-Type: text/plain
Date: Tue, 10 Apr 2007 11:12:14 -0400
Message-Id: <1176217934.14027.31.camel@saruman.qstreams.net>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: bwarren@qstreams.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Zhivko,

On Tue, 2007-04-10 at 16:51 +0200, powerpc440 wrote:
> Hello all,
> 
> I have multiple boards, based on ppc405ep (which include on-chip two
> ethernet ports). I'm configure the MAC address in u-boot and all works
> great. The problem appears when I use two or more boards in one network,
> because the MAC addresses are the same. Now I'm making a own u-boots for
> each board, but this solution is not very comfortable.
> My question is, which is the standard way to resolve such problem? I
> would have only one generic u-boot. Is this possible?
> 
> 
> Best regards,
> 
> Zhivko Yordanov

Please post to the U-boot mailing list.  There's no reason why you
should need to custom build for each board.  

You need to create some kind of board calibration procedure where each
board is assigned a unique MAC address, and then save it in U-boot.  If
your problem is that your unique U-boot MAC addresses don't make it to
Linux, the people on the U-boot list can give you direction.

regards,
Ben
