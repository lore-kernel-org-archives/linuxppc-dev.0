Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 8652B67B59
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Aug 2006 17:10:33 +1000 (EST)
To: "Dmitry Chichkov" <chichkov@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: U-Boot and kernel 2.6 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 31 Jul 2006 22:12:45 PDT."
	<eamnsh$v4b$1@sea.gmane.org>
Date: Tue, 01 Aug 2006 09:10:31 +0200
Sender: wd@denx.de
Message-Id: <20060801071031.3FEAD352625@atlas.denx.de>
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

In message <eamnsh$v4b$1@sea.gmane.org> you wrote:
> 
> I would recommend not to try old versions of U-Boot ("from 2.4") with new 
> linux kernels ("2.6").
> We had some troubles with invalid memory mappings in this configuration.

It is of course always a good idea to use  the  latest  and  greatest
versions  of  the software, but U-Boot is a boot loader, and it has a
clearly defined interface to the kernel  -  and  great  attempts  are
being  made  to  keep  this  interface  unchanged  or, if changes are
necessary, to perform them in a way that stays compatible.

I see no reason why even old versions of U-Boot could cause  problems
with  recent Linux kernels. Actually I have seen very old versions of
U-Boot (like U-Boot-0.3.x) seen in production use with recent  kernel
versions.



In your case it was probably a bug that had been fixed,  but  not  an
incompatibility with current kernels.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
panic: can't find /
