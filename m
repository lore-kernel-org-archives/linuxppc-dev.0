Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 53DFA67EFE
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Oct 2006 03:06:37 +1000 (EST)
To: tran vanle <vantranbk@yahoo.com.au>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Linux-2.6.x for TQM860L 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 26 Oct 2006 19:50:33 +1000."
	<20061026095033.85887.qmail@web33012.mail.mud.yahoo.com>
Date: Thu, 26 Oct 2006 19:06:34 +0200
Sender: wd@denx.de
Message-Id: <20061026170634.F40E43535FD@atlas.denx.de>
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

Hello,

in message <20061026095033.85887.qmail@web33012.mail.mud.yahoo.com> you wrote:
> 
>   I have just read pages
>   http://www.denx.de/wiki/Know/Linux24vs26 and i see you had build Linux-2.6.11.7 for TQM860L with instruction below 
>   Download  Kernel Version 2.6.11.7 from kernel.org plus 8xx v2.6 TLB patch by Marcelo Tosatti (4 Apr 2005)
>   Download config-2.6.11.7-TQM860L
>   Build instruction
> 
> -> export CROSS_COMPILE=ppc_8xx-
> -> cp ../config-2.6.11.7-TQM860L .config
> -> make ARCH=ppc CROSS_COMPILE=ppc_8xx- oldconfig
> -> time make -j8 ARCH=ppc CROSS_COMPILE=ppc_8xx- uImage
>    
>   I had done exactly these intruction but I received error 
>   Why? Had I missed another guide?

Did you use exact this kernel version, with Marcelo's patch  applied,
with the provided configuration file?

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
No one may kill a man.  Not for any purpose.  It cannot be condoned.
	-- Kirk, "Spock's Brain", stardate 5431.6
