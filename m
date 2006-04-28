Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id A3CC8679E6
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Apr 2006 05:11:27 +1000 (EST)
To: Kumar Gala <galak@kernel.crashing.org>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: FT u-boot shim 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 28 Apr 2006 11:01:20 CDT."
	<EA2821E8-FB7E-4DDA-8C18-C659B5483DC2@kernel.crashing.org>
Date: Fri, 28 Apr 2006 21:11:24 +0200
Sender: wd@denx.de
Message-Id: <20060428191124.B202B353DAC@atlas.denx.de>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <EA2821E8-FB7E-4DDA-8C18-C659B5483DC2@kernel.crashing.org>
Kumar Gala wrote:
> 
> What I envision as the way one boots for something like u-boot is one  
> of three options:
> 1. using an old u-boot + boot wrapper (bd_t -> wrapper -> kernel)
> 2. using a u-boot that is ft aware + dtb (boot command in u-boot  
> takes kernel & dtb images, updates blob and passes to kernel)
> 3. using a u-boot that is ft aware + built in dtb.
> 
> The issue is that for a given system/board you may need to support  
> multiple or all three.  This raises the question where does the .dts  

Assuming we had 2., under which circumstances would we need 3. then?


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A conservative is a man with two perfectly good legs  who  has  never
learned to walk.                              - Franklin D. Roosevelt
