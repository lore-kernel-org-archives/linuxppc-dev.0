Return-Path: <bgat@billgatliff.com>
Received: from mail-yx0-f181.google.com (mail-yx0-f181.google.com
	[209.85.210.181]) by ozlabs.org (Postfix) with ESMTP id 40546B7BF2
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jan 2010 15:38:23 +1100 (EST)
Received: by yxe11 with SMTP id 11so14622651yxe.15
	for <linuxppc-dev@ozlabs.org>; Tue, 05 Jan 2010 20:38:22 -0800 (PST)
Message-ID: <4B4413DA.7010704@billgatliff.com>
Date: Tue, 05 Jan 2010 22:38:50 -0600
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: Ayman El-Khashab <ayman@elkhashab.com>
Subject: Re: How to set GPIO state in the dts or in platform
References: <4B440EDC.3060805@elkhashab.com>
In-Reply-To: <4B440EDC.3060805@elkhashab.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ayman El-Khashab wrote:
> I've got a custom board akin to the walnut.  I've successfully got
> u-boot,
> the kernel, and a working filesystem.  The only thing I lack is a
> clear idea
> of how to set a GPIO.

Isn't that the "flags" parameter, e.g.:

gpios = <phandle gpioid flags>

?

If you are passing a 0 for the flags, try a 1.  I know of at least one
driver that interprets that to mean a polarity inversion.  Maybe you'll
get lucky.  :)


b.g.

-- 
Bill Gatliff
Embedded systems training and consulting
http://billgatliff.com
bgat@billgatliff.com
