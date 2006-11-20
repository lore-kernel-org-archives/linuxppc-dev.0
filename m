Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id DA98367BDC
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 20 Nov 2006 19:35:01 +1100 (EST)
To: "Leonid" <Leonid@a-k-a.net>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Perl 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 19 Nov 2006 20:21:07 PST."
	<406A31B117F2734987636D6CCC93EE3C0438F0@ehost011-3.exch011.intermedia.net>
Date: Mon, 20 Nov 2006 09:34:59 +0100
Sender: wd@denx.de
Message-Id: <20061120083459.29600353A53@atlas.denx.de>
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

In message <406A31B117F2734987636D6CCC93EE3C0438F0@ehost011-3.exch011.intermedia.net> you wrote:
>
> I've done this successfully with ELDK 4.0 and 3.1.1 on PPC440EP Yosemite
> board. Resulting perl binary is working with ELDK ppc_4xx filesystem
> (linux 2.6.13 has been used).
> 
> However it doesn't run on original Yosemite filesystem (I've copied all
> perl files there) - it doesn't find certain glibc symbols. With ELDK 4.0

What is your "original" filesystem? Any standard distro, or what?

> tmp # /opt/bin/perl warnings.pl
> /opt/bin/perl: relocation error: /opt/bin/perl: symbol __floatsidf,
> version GLIBC_2.3.2 not defined in file libc.so.6 wie

Looks as if you used the ppc_4xx packages for  this,  which  are  for
FPU-less  4xx  processors.  On  the  yosemite,  you  should  use  the
ppc_4xxFP tools instead.

> Did I something wrong?

Yes. You mixed soft-fload and hard-float binaries and libraries.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A princess should not be afraid -- not with a brave knight to protect
her.
	-- McCoy, "Shore Leave", stardate 3025.3
