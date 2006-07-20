Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 4EEC267B90
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Jul 2006 04:02:22 +1000 (EST)
Date: Thu, 20 Jul 2006 22:01:36 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: dhlii@comcast.net
Subject: Re: PHY Howto ?
Message-ID: <20060720220136.29326857@vitb.ru.mvista.com>
In-Reply-To: <44BFC2EF.5020305@dlasys.net>
References: <44BFC2EF.5020305@dlasys.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Thu, 20 Jul 2006 13:52:47 -0400
"David H. Lynch Jr." <dhlii@dlasys.net> wrote:

>  If I am writing a network MAC driver, for hardware that has a phy
> that is already supported, if I provide the appropriate mdio_read() and
> mdio_write() calls to access the phy registers, and setup my config to
> include phylib and drivers for my specific phy,  what else do I have to
> take care of with respect to the phy within my driver ?
> 	
> 	Are there some resources, howto's, examples, ... demonstrating 
> how to use phylib ?
There is pretty good writeup in Documentation about your concern, find it at 
Documentation/networking/phy.txt . Live example is obviously drivers/net/gianfar*


-- 
Sincerely, 
Vitaly
