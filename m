Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 3030F67A33
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Mar 2006 03:04:36 +1100 (EST)
To: David Hawkins <dwh@ovro.caltech.edu>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Linux on PPC 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 02 Mar 2006 21:10:43 PST."
	<4407CFD3.4060206@ovro.caltech.edu>
Date: Fri, 03 Mar 2006 17:04:34 +0100
Sender: wd@denx.de
Message-Id: <20060303160434.3886335261F@atlas.denx.de>
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

In message <4407CFD3.4060206@ovro.caltech.edu> you wrote:
> 
> If the vendor provided the VxWorks BSP, then hopefully they
> also provided you with the physical memory map of the board.
> This is what you really need to get another bootloader (eg. U-Boot)

This is *NOT* corect, and actually dangerous.

> Step 1. Get the memory map of the board.

Never use any given memory map unreflected. At least *check* if  it's
usable with Linux.

Many memory maps (especially those provides with some eval boards for
demonstration purpose) will NOT work with Linux.  Remember  that  the
memory  map  is  usually  not  cast  in  silicon,  but implemented in
software, so you can change it as needed.


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
C++ was an interesting and valuable experiment, but we've learned its
lessons and it's time to move on.
                            - Peter Curran in <DCqM4z.BxB@isgtec.com>
