Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 9290D67B90
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 11:09:00 +1100 (EST)
To: atul.sabharwal@exgate.tek.com
From: Wolfgang Denk <wd@denx.de>
Subject: Re: kernel startup 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 10 Feb 2006 15:53:33 PST."
	<4A062D477D842B4C8FC48EA5AF2D41F201BA207A@us-bv-m23.global.tektronix.net>
Date: Sat, 11 Feb 2006 01:08:58 +0100
Sender: wd@denx.de
Message-Id: <20060211000858.DAAAE3535F1@atlas.denx.de>
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

In message <4A062D477D842B4C8FC48EA5AF2D41F201BA207A@us-bv-m23.global.tektronix.net> you wrote:
> 
> >>How would something compressed uncompress itself?  If u-boot is being used 
> >>it will uncompress a compressed kernel and put the image at physical 0.
> 
> Small correction. Just like a self extracting binary, a kernel can have
> a decompression code prepended to the start of kernel which can decompress the 
> Kernel.  This is how redboot for xscale is structured or syslinux /lilo

No, this is not the kernel,  but  some  additional  component,  often
called "bootstrap loader" or so, which wraps the kernel as payload in
it's own image.

> Now, whether cache is enable or not, MMU is enabled/disabled depends on the
> Developer. In current u-boot, the MMU is not used. I-Cache is On and D-cache
> is off.

This may be correct on  some  specific  boards,  but  it's  wrong  on
others.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The existence of god implies a violation of causality.
